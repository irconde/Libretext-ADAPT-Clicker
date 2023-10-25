import 'dart:convert';
import 'package:adapt_clicker/backend/Router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:number_paginator/number_paginator.dart';
import '../constants/colors.dart';
import '../utils/Logger.dart';
import '../utils/app_theme.dart';
import '../utils/utils.dart';
import 'package:flutter/material.dart';
import '../constants/dimens.dart';
import '../backend/user_stored_preferences.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

/// Screen that displays information of a particular question
@RoutePage()
class QuestionScreen extends StatefulWidget {
  const QuestionScreen({
    Key? key,
    @PathParam('name') this.assignmentName,
    this.view,
    @PathParam('index') this.index = 0,
  }) : super(key: key);

  final String? assignmentName;
  final dynamic view;
  final int index;

  @override
  State<QuestionScreen> createState() => _QuestionScreenState(index, view);
}

/// The state class for the QuestionScreen widget.
class _QuestionScreenState extends State<QuestionScreen> {
  _QuestionScreenState(this._currentPage, this.view);
  TextEditingController? textController;

  int _currentPage;
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
    paginatorController.currentPage = _currentPage;
    pageController = PageController(initialPage: _currentPage);
    textController = TextEditingController();

  }

  Future<void> initView() async {

    //Push Notification Check
    view ??= AppState().view;

    //In app message for poll
    if (view == null) {
      if ((widget.assignmentName == '' || widget.assignmentName == null) && widget.index == 0) {
        context.popRoute();
        logger.w('Question page recieved no info');
      }else
      {
        view = await RouteHandler.getView(widget.assignmentName!);

        if(view == null) {
          context.popRoute();
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
          utf8.encode(AppState().urls.elementAt(widget.index)));
    }catch (e)
    {
      logger.w(e);
    }
    request = URLRequest(
      url: Uri.parse('https://adapt.libretexts.org/user-jwt-test/$redirectString'),
        headers: { 'authorization': UserStoredPreferences.authToken},
    );
  }


  @override
  Widget build(BuildContext context) {


    /*-----------------Building Page-----------------------*/
    return FutureBuilder(
      future: initView(),
      builder: (BuildContext context, snapshot) {
        if(view !=null){
        final questionsList = view['questions'];
        final int numPages = questionsList.length;
        var pages = List.generate(
          numPages,
              (index) => Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      child: SizedBox(
                        height: 400,
                        child: InAppWebView(
                          initialUrlRequest: request,
                          onWebViewCreated: (controller) async {
                            Cookie cookie =  AppState().cookie;

                            webViewController = controller;
                            _cookieManager.setCookie(url: request.url!, name: cookie.name, value:cookie.value, iosBelow11WebViewController: controller);
                            injectViewport(controller);
                          },
                          onLoadStart: (controller, uri) {
                            injectViewport(controller);

                          },
                          initialOptions: options,
                          gestureRecognizers: Set()
                            ..add(Factory(() => EagerGestureRecognizer()))
                            ..add(Factory<VerticalDragGestureRecognizer>(
                                    () => VerticalDragGestureRecognizer())),
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
                icon: const Icon(
                  Icons.arrow_back,
                  color: CColors.primaryBackground,
                ),
                onPressed: () {
                  context.popRoute();
                },
              ),
              title: Text(
                widget.assignmentName!,
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: AppTheme.of(context).bodyText1.override(
                    fontFamily: 'Open Sans',
                    color: CColors.primaryBackground,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
            body: PageView(
                physics: const BouncingScrollPhysics(),
                controller: pageController,
                onPageChanged: (index) {
                  final questionsListItem = questionsList[index];
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
                      padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 0),
                      child: NumberPaginator(
                        controller: paginatorController,
                        config: const NumberPaginatorUIConfig(
                          buttonShape: ContinuousRectangleBorder(
                            side: BorderSide(color: CColors.outlineColor, width: 1),
                          ),
                          buttonSelectedForegroundColor: CColors.primaryBackground,
                          buttonUnselectedForegroundColor: CColors.primaryColor,
                          buttonUnselectedBackgroundColor:
                              CColors.primaryBackground,
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
                              urlRequest: URLRequest(url: Uri.tryParse(url)),
                            );

                          });
                          UserStoredPreferences.selectedIndex = index;
                        },
                      ),
                    ),
                  ],
                )));

        }else {
          return Container();
        }
      }
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
