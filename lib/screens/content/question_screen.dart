import 'dart:convert';
import 'package:adapt_clicker/backend/Router/app_router.dart';
import 'package:adapt_clicker/constants/icons.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:number_paginator/number_paginator.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../utils/logger.dart';
import '../../utils/app_theme.dart';
import '../../utils/utils.dart';
import 'package:flutter/material.dart';
import '../../constants/dimens.dart';
import '../../backend/user_stored_preferences.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

/// Screen that displays information of a particular question
@RoutePage()
class QuestionScreen extends StatefulWidget {
  const QuestionScreen({
    Key? key,
    @PathParam('name') this.assignmentName,
    this.view,
    @PathParam('index') this.index = 0,
    this.isIndex = false,
  }) : super(key: key);

  final String? assignmentName;
  final dynamic view;
  final int index;
  final bool isIndex;

  @override
  State<QuestionScreen> createState() => _QuestionScreenState(index, view);
}

/// The state class for the QuestionScreen widget.
class _QuestionScreenState extends State<QuestionScreen> {
  _QuestionScreenState(this.currentID, this.view);
  TextEditingController? textController;

  final int currentID;
  int _currentPage = 0;
  late dynamic view;
  NumberPaginatorController paginatorController = NumberPaginatorController();
  PageController pageController = PageController();
  bool isLoading = true;


  final CookieManager _cookieManager = CookieManager.instance();
  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
        supportZoom: true,
        javaScriptEnabled: true,
        javaScriptCanOpenWindowsAutomatically: true,
        cacheEnabled: true,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late URLRequest request;

  @override
  void initState() {
    super.initState();
    setPageFromID();

    textController = TextEditingController();

  }



  @override
  Widget build(BuildContext context) {


      /*-----------------Building Page-----------------------*/
      return FutureBuilder(
          future: initView(),
          builder: (BuildContext context, snapshot) {
            try {
              if (view != null) {
                final questionsList = view['questions'];
                final int numPages = questionsList.length;
                var pages = List.generate(
                  numPages,
                      (index) =>
                      Center(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Card(
                                  child: SizedBox(
                                    height: 400,
                                    child: InAppWebView(
                                      initialUrlRequest: request,
                                      onWebViewCreated: (controller) async {
                                        Cookie cookie = AppState().cookie;
                                        webViewController = controller;
                                        _cookieManager.setCookie(
                                            url: request.url!,
                                            name: cookie.name,
                                            value: cookie.value,
                                            iosBelow11WebViewController: controller);
                                        injectViewport(controller);
                                      },
                                      onLoadStart: (controller, uri) {
                                        injectViewport(controller);
                                      },
                                      initialOptions: options,
                                      gestureRecognizers: Set()
                                        ..add(Factory(() =>
                                            EagerGestureRecognizer()))..add(
                                            Factory<
                                                VerticalDragGestureRecognizer>(
                                                    () =>
                                                    VerticalDragGestureRecognizer())),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                );

                return Scaffold(
                    resizeToAvoidBottomInset: false,
                    backgroundColor: CColors.primaryBackground,
                    appBar: AppBar(
                      backgroundColor: CColors.primaryColor,
                      leading: IconButton(
                        icon: IIcons.back,
                        onPressed: () {
                          context.popRoute();
                        },
                      ),
                      title: Text(
                        widget.assignmentName!,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: AppTheme.of(context).title3
                      ),
                    ),
                    body: PageView(
                        physics: const BouncingScrollPhysics(),
                        controller: pageController,
                        onPageChanged: (index) {
                          setState(() {
                            String url = AppState().urls[index];
                            setState(() {
                              // Load the URL in your web view controller
                              webViewController?.loadUrl(
                                urlRequest: URLRequest(url: Uri.tryParse(url)),
                              );
                            });
                            UserStoredPreferences.selectedIndex = index;
                            paginatorController.currentPage = index;
                          });
                        },
                        children: pages),
                    bottomNavigationBar: Card(
                        elevation: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Divider(
                              thickness: Dimens.dividerThickness,
                              indent: 16,
                              endIndent: 16,
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  Dimens.msMargin, Dimens.sMargin, Dimens.msMargin, 0),
                              child: NumberPaginator(
                                controller: paginatorController,
                                config: const NumberPaginatorUIConfig(
                                  buttonShape: ContinuousRectangleBorder(
                                    side: BorderSide(color: CColors.outlineColor, width: 1),
                                  ),
                                  buttonSelectedForegroundColor: CColors.primaryBackground,
                                  buttonUnselectedForegroundColor: CColors.primaryColor,
                                  buttonUnselectedBackgroundColor: CColors.primaryBackground,
                                  buttonSelectedBackgroundColor: CColors.primaryColor,
                                ),

                                initialPage: _currentPage,
                                // by default, the paginator shows numbers as center content
                                numberPages: numPages,
                                onPageChange: (index) async {
                                  String url = AppState().urls[index];
                                  setState(() {
                                    // Load the URL in your web view controller
                                    webViewController?.loadUrl(
                                      urlRequest: URLRequest(
                                          url: Uri.tryParse(url)),
                                    );
                                  });
                                  UserStoredPreferences.selectedIndex = index;
                                },
                              ),
                            ),
                          ],
                        )));
              } else {
                return Container();
              }

            }
            catch(e)
            {
              logger.e('Question page failed $e');
              context.router.pop();
              return Container();

            }
          }
      );
  }


  void setPageFromID()
  {
    try {
      if (!widget.isIndex) { //Means it is an ID
        _currentPage = AppState().questionIDs.indexOf(currentID);
      }
      else {
        _currentPage = currentID; //Index passed directly in
      }

      paginatorController.currentPage = _currentPage;
      pageController = PageController(initialPage: _currentPage);
    }
    catch(e)
    {
      logger.e('Question page failed to open: $e');
      context.router.pop;

    }
  }

  Future<void> initView() async {

    //Push Notification Check
    view ??= AppState().view;

    //In app message for poll
    if (view == null) {
      if ((widget.assignmentName == '' || widget.assignmentName == null) && currentID == 0) {
        AppState().router.pop();
        logger.w('Question page recieved no info');
      }else
      {
        view = await RouteHandler.getView(widget.assignmentName!);

        if(view == null) {
          AppState().router.pop();
          logger.e('Invalid Assignment ID');
        }
      }
    }
    setupHttpCredentials();
  }

  Future<void> setupHttpCredentials() async {
    String redirectString = '';
    try {
      redirectString = base64Url.encode(
          utf8.encode(AppState().urls.elementAt(_currentPage)));
    }catch (e)
    {
      logger.w(e);
    }
    request = URLRequest(
      url: Uri.parse('${Strings.adaptLink}/user-jwt-test/$redirectString'),
      headers: { 'authorization': UserStoredPreferences.authToken},
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

/// Injects the viewport meta tag into the given [controller].
void injectViewport(InAppWebViewController controller) async {
  await controller.evaluateJavascript(
      source:
          '''var flutterViewPort=document.createElement("meta"); flutterViewPort.name = "viewport"; flutterViewPort.content = "width=400, initial-scale=1.0, maximum-scale=2.0, user-scalable=1"; document.getElementsByTagName("head")[0].appendChild(flutterViewPort);''');
}
