import 'dart:io';
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
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
                Constants.sMargin, Constants.msMargin, Constants.mmMargin, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                    size: Constants.mlMargin,
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                    child: Text(
                  widget.assignmentName!,
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Open Sans',
                      color: FlutterFlowTheme.of(context).primaryColor,
                      fontSize: Constants.msMargin,
                      fontWeight: FontWeight.bold),
                )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
                Constants.msMargin, Constants.msMargin, Constants.msMargin, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 24),
                    child: RichText(
                        text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Question Points: ',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        TextSpan(
                          text: getJsonField(
                            FFAppState().question,
                            r'''$.points''',
                          ).toString().maybeHandleOverflow(
                                maxChars: 32,
                                replacement: '…',
                              ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ],
                    )),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                    child: RichText(
                        text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Attempts: ',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        TextSpan(
                          text: getJsonField(
                            FFAppState().question,
                            r'''$.submission_count''',
                          ).toString().maybeHandleOverflow(
                                maxChars: 32,
                                replacement: '…',
                              ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ],
                    )),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                    child: RichText(
                        text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Submission: ',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        TextSpan(
                          text: getJsonField(
                            FFAppState().question,
                            r'''$.student_response''',
                          ).toString().maybeHandleOverflow(
                                maxChars: 32,
                                replacement: '…',
                              ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ],
                    )),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                    child: RichText(
                        text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Submitted: ',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        TextSpan(
                          text: getJsonField(
                            FFAppState().question,
                            r'''$.last_submitted''',
                          ).toString().maybeHandleOverflow(
                                maxChars: 32,
                                replacement: '…',
                              ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ],
                    )),
                  ),
                  if (FFAppState().isBasic)
                    Container(
                      height: 256,
                      padding: EdgeInsets.all(2),
                      color: Colors.green,
                      child: WebView(
                        initialUrl: getJsonField(
                          FFAppState().question,
                          r'''$.technology_iframe''',
                        ),
                        onWebViewCreated:
                            (WebViewController webViewController) {
                          controller = webViewController;
                          injectViewport(controller);
                        },
                        onPageFinished: (url)
                        {
                          injectViewport(controller);
                        },
                        javascriptMode: JavascriptMode.unrestricted,
                        gestureNavigationEnabled: true,
                        gestureRecognizers: Set()
                          ..add(Factory(() => EagerGestureRecognizer()))
                          ..add(Factory<VerticalDragGestureRecognizer>(
                              () => VerticalDragGestureRecognizer())),
                        zoomEnabled: true,
                      ),
                    ),
                  if (!FFAppState().isBasic)
                    FutureBuilder<ApiCallResponse>(
                      future: GetNonTechnologyIframeCall.call(
                        pageId: getJsonField(
                          FFAppState().question,
                          r'''$.page_id''',
                        ),
                        token: FFAppState().authToken,
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                              ),
                            ),
                          );
                        }
                        final htmlViewGetNonTechnologyIframeResponse =
                            snapshot.data!;
                        return Html(
                          data: htmlViewGetNonTechnologyIframeResponse.jsonBody,
                        );
                      },
                    ),
                  if (functions.isTextSubmission(getJsonField(
                    FFAppState().question,
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
                          padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                          child: FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: 'Submit',
                            options: FFButtonOptions(
                              width: 130,
                              height: 40,
                              color: FlutterFlowTheme.of(context).primaryColor,
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
          ),
          if (!(kIsWeb
              ? MediaQuery.of(context).viewInsets.bottom > 0
              : _isKeyboardVisible))
            Padding(
              padding: const EdgeInsets.all(Constants.mmMargin),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_left,
                      color: Colors.black,
                      size: 24,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                      child: Builder(
                        builder: (context) {
                          final questionsList = getJsonField(
                            FFAppState().view,
                            r'''$.questions''',
                          ).toList();
                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            children: List.generate(questionsList.length,
                                (questionsListIndex) {
                              final questionsListItem =
                                  questionsList[questionsListIndex];
                              return Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                                child: InkWell(
                                  onTap: () async {
                                    setState(() => FFAppState().question =
                                        questionsListItem);
                                    setState(() => FFAppState().isBasic =
                                            functions.isBasic(getJsonField(
                                          questionsListItem,
                                          r'''$.technology_iframe''',
                                        ).toString()));
                                    setState(() => FFAppState().hasSubmission =
                                            getJsonField(
                                          questionsListItem,
                                          r'''$.has_at_least_one_submission''',
                                        ));
                                    setState(() => controller.loadUrl(
                                        getJsonField(questionsListItem,
                                            r'''$.technology_iframe'''))
                                    );
                                    setState(() {

                                    });


                                  },
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Text(
                                      functions
                                          .addOne(questionsListIndex)
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                          ),
                                    ),
                                  ),
                                ),
                              );
                            }),
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
              ),
            ),
        ],
      ),
    );
  }
}

void injectViewport(WebViewController controller) async {

    controller.runJavascriptReturningResult('''
                          var flutterViewPort=document.createElement('meta');
                          flutterViewPort.name =    "viewport";
                          flutterViewPort.content = "initial-scale=1.0, maximum-scale=1.0, user-scalable=0";
                          document.getElementsByTagName('head')[0].appendChild(flutterViewPort);
                          ''');

    log('Run');
}
