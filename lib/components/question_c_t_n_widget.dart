import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../gen/assets.gen.dart';
import 'dart:developer';

import '../utils/stored_preferences.dart';

class QuestionCTNWidget extends StatefulWidget {
  const QuestionCTNWidget({
    Key? key,
    this.assignmentName,
  }) : super(key: key);

  final String? assignmentName;

  @override
  _QuestionCTNWidgetState createState() => _QuestionCTNWidgetState();
}

class _QuestionCTNWidgetState extends State<QuestionCTNWidget> {
  TextEditingController? textController;

  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;
  late WebViewController controller;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      _keyboardVisibilitySubscription =
          KeyboardVisibilityController().onChange.listen((bool visible) {
        setState(() {
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

  @override
  Widget build(BuildContext context) {
    final questionsList = getJsonField(
      AppState().view,
      r'''$.questions''',
    ).toList();

    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.grey,
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
              color: FlutterFlowTheme.of(context).primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(
                    indent: Constants.mmMargin,
                    endIndent: Constants.mmMargin,
                    thickness: Constants.dividerThickness,
                    height: 1,
                    color: FlutterFlowTheme.of(context).lineColor,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        Constants.mmMargin,
                        Constants.msMargin,
                        Constants.mmMargin,
                        Constants.sMargin),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 16, 0, 24),
                              child: RichText(
                                  text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Points: ',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  TextSpan(
                                    text: getJsonField(
                                      AppState().question,
                                      r'''$.points''',
                                    ).toString().maybeHandleOverflow(
                                          maxChars: 32,
                                          replacement: '…',
                                        ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ],
                              )),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                              child: RichText(
                                  text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Attempts: ',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  TextSpan(
                                    text: getJsonField(
                                      AppState().question,
                                      r'''$.submission_count''',
                                    ).toString().maybeHandleOverflow(
                                          maxChars: 32,
                                          replacement: '…',
                                        ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ],
                              )),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                              child: RichText(
                                  text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Submission: ',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  TextSpan(
                                    text: getJsonField(
                                      AppState().question,
                                      r'''$.student_response''',
                                    ).toString().maybeHandleOverflow(
                                          maxChars: 32,
                                          replacement: '…',
                                        ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ],
                              )),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                              child: RichText(
                                  text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Submitted: ',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  TextSpan(
                                    text: getJsonField(
                                      AppState().question,
                                      r'''$.last_submitted''',
                                    ).toString().maybeHandleOverflow(
                                          maxChars: 32,
                                          replacement: '…',
                                        ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ],
                              )),
                            ),
                            if (AppState().isBasic)
                              Card(
                                child: Container(
                                  height: 256,
                                  child: WebView(
                                    initialUrl: getJsonField(
                                      AppState().question,
                                      r'''$.technology_iframe''',
                                    ),
                                    onWebViewCreated:
                                        (WebViewController webViewController) {
                                      controller = webViewController;
                                      injectViewport(controller);
                                    },
                                    onPageFinished: (url) {
                                      injectViewport(controller);
                                    },
                                    javascriptMode: JavascriptMode.unrestricted,
                                    gestureNavigationEnabled: true,
                                    gestureRecognizers: Set()
                                      ..add(
                                          Factory(() => EagerGestureRecognizer()))
                                      ..add(Factory<
                                              VerticalDragGestureRecognizer>(
                                          () => VerticalDragGestureRecognizer())),
                                    zoomEnabled: true,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        if (!AppState().isBasic)
                          FutureBuilder<ApiCallResponse>(
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
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
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
                                  hintStyle:
                                      FlutterFlowTheme.of(context).bodyText2,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context).bodyText1,
                                maxLines: 16,
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                                child: FFButtonWidget(
                                  onPressed: () {
                                    print('Button pressed ...');
                                  },
                                  text: 'Submit',
                                  options: FFButtonOptions(
                                    width: 130,
                                    height: 40,
                                    color:
                                        FlutterFlowTheme.of(context).primaryColor,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .subtitle2
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: Colors.white,
                                        ),
                                    borderSide: BorderSide(
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
                  ),
                ],
              ),
            ),
          ),
          Divider(
            indent: Constants.mmMargin,
            endIndent: Constants.mmMargin,
            thickness: Constants.dividerThickness,
            color: FlutterFlowTheme.of(context).lineColor,
          ),
          if (!(kIsWeb
              ? MediaQuery.of(context).viewInsets.bottom > 0
              : _isKeyboardVisible))
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_left,
                    color: Colors.black,
                    size: 24,
                  ),
                  Container(
                    width: 240,
                    height: 48,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: questionsList.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 12);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        final questionsListItem = questionsList[index];
                        return InkWell(
                          splashColor: Colors.transparent,
                          onTap: () async {
                            setState(() {
                              AppState().question = questionsListItem;
                              AppState().isBasic =
                                  functions.isBasic(getJsonField(
                                questionsListItem,
                                r'''$.technology_iframe''',
                              ).toString());
                              AppState().hasSubmission = getJsonField(
                                questionsListItem,
                                r'''$.has_at_least_one_submission''',
                              );
                              controller.loadUrl(getJsonField(questionsListItem,
                                  r'''$.technology_iframe'''));
                              log("Setting index to $index");
                              StoredPreferences.selectedIndex = index;
                            });
                          },
                          child: containerSelection(++index, context),
                        );
                      },
                    ),
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: Colors.black,
                    size: 24,
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}

Widget containerSelection(index, context) {
  bool selected = false;
  int a = StoredPreferences.selectedIndex;

  log("Index: $index, selected: $a");

  if (index == StoredPreferences.selectedIndex) selected = true;

  if (selected)
    return selectedQuestionCard(index, context);
  else
    return unselectedQuestionCard(index, context);
}

Widget selectedQuestionCard(int index, BuildContext context) => Container(
      alignment: AlignmentDirectional(0, 0),
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryColor,
        shape: BoxShape.circle,
      ),
      child: Text(
        '$index',
        style: FlutterFlowTheme.of(context).bodyText1.override(
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: FlutterFlowTheme.of(context).primaryBackground,
            ),
        textAlign: TextAlign.center,
      ),
    );

Widget unselectedQuestionCard(int index, BuildContext context) => Container(
      alignment: AlignmentDirectional(0, 0),
      width: 32,
      height: 32,
      decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          shape: BoxShape.circle,
          border: Border.all(
              width: .4, color: FlutterFlowTheme.of(context).tertiaryColor)),
      child: Text(
        '$index',
        style: FlutterFlowTheme.of(context).bodyText1.override(
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: FlutterFlowTheme.of(context).primaryColor,
            ),
        textAlign: TextAlign.center,
      ),
    );

void injectViewport(WebViewController controller) async {
  controller.runJavascriptReturningResult('''
                          var flutterViewPort=document.createElement('meta');
                          flutterViewPort.name =    "viewport";
                          flutterViewPort.content = "initial-scale=1.0, maximum-scale=1.0, user-scalable=0";
                          document.getElementsByTagName('head')[0].appendChild(flutterViewPort);
                          ''');

  log('Run');
}
