import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:number_paginator/number_paginator.dart';
import '../backend/api_requests/api_calls.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../utils/app_theme.dart';
import '../widgets/buttons/custom_button_widget.dart';
import '../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../constants/dimens.dart';
import '../backend/user_stored_preferences.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

@RoutePage()
class QuestionScreen extends StatefulWidget {
  const QuestionScreen({
    Key? key,
    @PathParam('name') this.assignmentName,
    @PathParam('view') this.view,
    this.index = 0,
  }) : super(key: key);

  final String? assignmentName;
  final dynamic view;
  final int index;

  @override
  State<QuestionScreen> createState() => _QuestionScreenState(index);
}

class _QuestionScreenState extends State<QuestionScreen> {
  _QuestionScreenState(this._currentPage);
  TextEditingController? textController;
  int _currentPage;
  NumberPaginatorController paginatorController = NumberPaginatorController();
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    paginatorController.currentPage = _currentPage;
    pageController = PageController(initialPage: _currentPage);
    textController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    final questionsList = widget.view['questions'];
    final int numPages = questionsList.length;
    var pages = List.generate(
      numPages,
      (index) => Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            AppState().isBasic
                ? Card(
                    child: SizedBox(
                      height: 400,
                      child: InAppWebView(
                        initialUrlRequest: URLRequest(
                            url: Uri.parse(
                                AppState().question['technology_iframe'])),
                        onWebViewCreated: (controller) {
                          webViewController = controller;
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
                : FutureBuilder<ApiCallResponse>(
                    future: GetNonTechnologyIframeCall.call(
                      pageId: getJsonField(
                        AppState().question,
                        r'''$.page_id''',
                      ),
                      token: UserStoredPreferences.authToken,
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return const Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              color: CColors.primaryColor,
                            ),
                          ),
                        );
                      }
                      final htmlViewGetNonTechnologyIframeResponse =
                          snapshot.data!;
                      return Html(
                        data: htmlViewGetNonTechnologyIframeResponse
                            .elements.outerHtml,
                      );
                    },
                  ),
            if (isTextSubmission(getJsonField(
              AppState().question,
              r'''$.open_ended_submission_type''',
            ).toString()))
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextFormField(
                    controller: textController,
                    autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: Strings.genericHintText,
                      hintStyle: AppTheme.of(context).bodyText2,
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: CColors.noColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: CColors.noColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      errorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: CColors.noColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedErrorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: CColors.noColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                    ),
                    style: AppTheme.of(context).bodyText1,
                    maxLines: 16,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                    child: CustomButtonWidget(
                      onPressed: () {
                        // TODO. Check this. What is this for?
                        //print('Button pressed ...');
                      },
                      text: 'Submit',
                      options: ButtonOptions(
                        width: 130,
                        height: 40,
                        color: CColors.primaryColor,
                        textStyle: AppTheme.of(context).subtitle2.override(
                              fontFamily: 'Open Sans',
                              color: Colors.white,
                            ),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      )),
    );

    /*-----------------Building Page-----------------------*/
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
                AppState().question = questionsListItem;
                AppState().isBasic =
                    isBasic(questionsListItem['technology_iframe']);
                AppState().hasSubmission =
                    questionsListItem['has_at_least_one_submission'];
                webViewController?.loadUrl(
                    urlRequest: URLRequest(
                        url:
                            Uri.parse(questionsListItem['technology_iframe'])));

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
                      final questionsListItem = questionsList[index];
                      setState(() {
                        AppState().question = questionsListItem;
                        AppState().isBasic =
                            isBasic(questionsListItem['technology_iframe']);
                        AppState().hasSubmission =
                            questionsListItem['has_at_least_one_submission'];
                        webViewController?.loadUrl(
                            urlRequest: URLRequest(
                                url: Uri.parse(
                                    questionsListItem['technology_iframe'])));
                        UserStoredPreferences.selectedIndex = index;
                      });
                    },
                  ),
                ),
              ],
            )));
  }
}

void injectViewport(InAppWebViewController controller) async {
  await controller.evaluateJavascript(
      source:
          '''var flutterViewPort=document.createElement("meta"); flutterViewPort.name = "viewport"; flutterViewPort.content = "width=400, initial-scale=1.0, maximum-scale=2.0, user-scalable=1"; document.getElementsByTagName("head")[0].appendChild(flutterViewPort);''');
}