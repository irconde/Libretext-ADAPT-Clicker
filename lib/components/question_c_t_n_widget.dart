import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_web_view.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(-0.93, 0),
                child: InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close_outlined,
                    color: Colors.black,
                    size: 36,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Text(
                  widget.assignmentName!,
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Open Sans',
                        color: FlutterFlowTheme.of(context).primaryColor,
                        fontSize: 24,
                      ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Question Points: ',
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                        Text(
                          getJsonField(
                            FFAppState().question,
                            r'''$.points''',
                          ).toString(),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Attempts: ',
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                        Text(
                          getJsonField(
                            FFAppState().question,
                            r'''$.submission_count''',
                          ).toString(),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Submission: ',
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                        Text(
                          getJsonField(
                            FFAppState().question,
                            r'''$.student_response''',
                          ).toString().maybeHandleOverflow(
                                maxChars: 40,
                                replacement: '…',
                              ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Submitted: ',
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                        Text(
                          getJsonField(
                            FFAppState().question,
                            r'''$.last_submitted''',
                          ).toString(),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  if (FFAppState().isBasic)
                    FlutterFlowWebView(
                      url: getJsonField(
                        FFAppState().question,
                        r'''$.technology_iframe''',
                      ),
                      bypass: false,
                      height: 500,
                      verticalScroll: true,
                      horizontalScroll: true,
                    ),
                  if (!FFAppState().isBasic)
                    Html(
                      data: getJsonField(
                        FFAppState().question,
                        r'''$.non_technology_iframe_src''',
                      ).toString(),
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
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                          maxLines: 16,
                        ),
                        FFButtonWidget(
                          onPressed: () {
                            print('Button pressed ...');
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
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
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
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                            child: InkWell(
                              onTap: () async {
                                setState(() =>
                                    FFAppState().question = questionsListItem);
                                setState(() => FFAppState().isBasic =
                                        functions.isBasic(getJsonField(
                                      questionsListItem,
                                      r'''$.non_technology''',
                                    )));
                                setState(() =>
                                    FFAppState().hasSubmission = getJsonField(
                                      questionsListItem,
                                      r'''$.has_at_least_one_submission''',
                                    ));
                              },
                              child: Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
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
    );
  }
}
