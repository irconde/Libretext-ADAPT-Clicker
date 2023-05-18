import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:number_paginator/number_paginator.dart';
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'dart:developer';
import '../utils/constants.dart';
import '../utils/stored_preferences.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


@RoutePage()
class QuestionCTNWidget extends StatefulWidget {
  const QuestionCTNWidget(
      {Key? key,
      @PathParam('name') this.assignmentName,
      @PathParam('view') this.view,
      this.index = 0,})
      : super(key: key);

  final String? assignmentName;
  final dynamic view;
  final int index;

  @override
  State<QuestionCTNWidget> createState() => _QuestionCTNWidgetState(index);
}

class _QuestionCTNWidgetState extends State<QuestionCTNWidget> {
  _QuestionCTNWidgetState(this._currentPage);

  TextEditingController? textController;

  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  int _currentPage;

  NumberPaginatorController paginatorController = NumberPaginatorController();
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    paginatorController.currentPage = _currentPage;
    pageController = PageController(initialPage: _currentPage);
    if (kIsWeb) {
      _keyboardVisibilitySubscription =
          KeyboardVisibilityController().onChange.listen((bool visible) {
        setState!(() {
          _isKeyboardVisible = visible;
        });
      });
    }

    textController = TextEditingController();
  }

  @override
  void dispose() {
    if (!kIsWeb) {
      _keyboardVisibilitySubscription.cancel();
    }
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
                          initialUrlRequest: URLRequest(url: Uri.parse(AppState().question['technology_iframe'])),
                          onWebViewCreated: (controller) {
                            webViewController = controller;
                            injectViewport(controller);
                          },
                          onLoadStart: (controller, uri)
                          {
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
                        token: StoredPreferences.authToken,
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                color: FlutterFlowTheme.of(context).primaryColor,
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
                    if (functions.isTextSubmission(getJsonField(
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
                              hintText: '[Some hint text...]',
                              hintStyle: FlutterFlowTheme.of(context).bodyText2,
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              errorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              focusedErrorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                            ),
                            style: FlutterFlowTheme.of(context).bodyText1,
                            maxLines: 16,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                            child: FFButtonWidget(
                              onPressed: () {
                                // TODO. Check this. What is this for?
                                //print('Button pressed ...');
                              },
                              text: 'Submit',
                              options: FFButtonOptions(
                                width: 130,
                                height: 40,
                                color: FlutterFlowTheme.of(context).primaryColor,
                                textStyle:
                                FlutterFlowTheme.of(context).subtitle2.override(
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
              )
          ),
    );

    /*-----------------Building Page-----------------------*/
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,

              color: FlutterFlowTheme.of(context).primaryBackground,
            ),
            onPressed: () {
              context.popRoute();
            },
          ),
          title: Text(
            widget.assignmentName!,
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'Open Sans',
                color: FlutterFlowTheme.of(context).primaryBackground,
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
                AppState().isBasic =  functions.isBasic(questionsListItem['technology_iframe']);
                AppState().hasSubmission = questionsListItem['has_at_least_one_submission'];
                webViewController?.loadUrl(urlRequest: URLRequest(url: Uri.parse(questionsListItem['technology_iframe'])));

                StoredPreferences.selectedIndex = index;
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
                  thickness: Constants.dividerThickness,
                  indent: 16,
                  endIndent: 16,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 0),
                  child: NumberPaginator(
                    controller: paginatorController,
                    config: NumberPaginatorUIConfig(
                      buttonShape: ContinuousRectangleBorder(
                        side: BorderSide(
                          color: FlutterFlowTheme.of(context).outlineColor,
                          width: 1
                        ),
                      ),
                      buttonSelectedForegroundColor: FlutterFlowTheme.of(context).primaryBackground,
                      buttonUnselectedForegroundColor:  FlutterFlowTheme.of(context).primaryColor,
                      buttonUnselectedBackgroundColor:  FlutterFlowTheme.of(context).primaryBackground,
                      buttonSelectedBackgroundColor: FlutterFlowTheme.of(context).primaryColor,
                    ),

                    initialPage: _currentPage,
                    // by default, the paginator shows numbers as center content
                    numberPages: numPages,
                    onPageChange: (index) async {
                      final questionsListItem = questionsList[index];
                      setState(() {
                        AppState().question = questionsListItem;
                        AppState().isBasic =  functions.isBasic(questionsListItem['technology_iframe']);
                        AppState().hasSubmission = questionsListItem['has_at_least_one_submission'];
                        webViewController?.loadUrl(urlRequest: URLRequest(url: Uri.parse(questionsListItem['technology_iframe'])));
                        StoredPreferences.selectedIndex = index;
                      });
                    },
                  ),
                ),
              ],
            )
        )
    );
  }
}

void injectViewport(InAppWebViewController controller) async {

  await controller.evaluateJavascript(source: '''var flutterViewPort=document.createElement("meta"); flutterViewPort.name = "viewport"; flutterViewPort.content = "width=400, initial-scale=1.0, maximum-scale=2.0, user-scalable=1"; document.getElementsByTagName("head")[0].appendChild(flutterViewPort);''');
}
