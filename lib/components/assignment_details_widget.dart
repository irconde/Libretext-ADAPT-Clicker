import 'package:adapt_clicker/utils/stored_preferences.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/api_requests/api_calls.dart';
import '../components/question_c_t_n_widget.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../gen/assets.gen.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import '../utils/check_internet_connectivity.dart';

class AssignmentDetailsWidget extends ConsumerStatefulWidget {
  const AssignmentDetailsWidget({
    Key? key,
    this.assignmentSum,
  }) : super(key: key);

  final dynamic assignmentSum;

  @override
  _AssignmentDetailsWidgetState createState() =>
      _AssignmentDetailsWidgetState();
}

class _AssignmentDetailsWidgetState
    extends ConsumerState<AssignmentDetailsWidget>
    with TickerProviderStateMixin {
  final animationsMap = {
    'textOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      duration: 600,
      hideBeforeAnimating: false,
      initialState: AnimationState(
        offset: Offset(0, 0),
        scale: 1,
        opacity: 0,
      ),
      finalState: AnimationState(
        offset: Offset(0, 0),
        scale: 1,
        opacity: 1,
      ),
    ),
  };

  bool _checkConnection() {
    ConnectivityStatus? status =
        ref.read(provider.notifier).getConnectionStatus();
    if (status != ConnectivityStatus.isConnected) {
      functions.showSnackbar(context, status);
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    setupTriggerAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onActionTrigger),
      this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  0, Constants.mmMargin, Constants.mmMargin, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey,
                      size: 28,
                    ),
                    onPressed: () async {
                      context.popRoute();
                    },
                  ),
                  Expanded(
                    child: Text(
                      getJsonField(
                        widget.assignmentSum,
                        r'''$.name''',
                      ).toString(),
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: FlutterFlowTheme.of(context).primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ).animated(
                        [animationsMap['textOnActionTriggerAnimation']!]),
                  ),
                ],
              ),
            ),
            Divider(
              indent: Constants.mmMargin,
              endIndent: Constants.mmMargin,
              thickness: Constants.dividerThickness,
            ),
            Padding(
              padding: const EdgeInsets.all(Constants.mmMargin),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        0, 0, 0, Constants.msMargin),
                    child: RichText(
                      text: TextSpan(
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                            ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Number of Points: ',
                          ),
                          TextSpan(
                            text: "This assignment is worth a total of " +
                                getJsonField(
                                  widget.assignmentSum,
                                  r'''$.total_points''',
                                ).toString() +
                                " points",
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.normal,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        0, 0, 0, Constants.msMargin),
                    child: RichText(
                      text: TextSpan(
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w600,
                                  ),
                          children: [
                            TextSpan(
                              text: 'Number of Questions: ',
                            ),
                            TextSpan(
                              text: "This assignment has " +
                                  getJsonField(
                                    widget.assignmentSum,
                                    r'''$.number_of_questions''',
                                  ).toString() +
                                  " questions",
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        0, 0, 0, Constants.msMargin),
                    child: RichText(
                      text: TextSpan(
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                            ),
                        children: [
                          TextSpan(
                            text: 'Due Date: ',
                          ),
                          TextSpan(
                            text: "This assignment is due by " +
                                getJsonField(
                                  widget.assignmentSum,
                                  r'''$.formatted_due''',
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
                  ),
                  Container(
                    width: double.infinity,
                    height: 75,
                    decoration: BoxDecoration(),
                    child: RichText(
                      text: TextSpan(
                        style: FlutterFlowTheme.of(context).bodyText1,
                        children: <TextSpan>[
                          TextSpan(
                            text: "Late Policy: ",
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                          TextSpan(
                            text: getJsonField(
                              widget.assignmentSum,
                              r'''$.formatted_late_policy''',
                            ).toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0x00FFFFFF),
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional(0, 0),
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Divider(
                              thickness: Constants.dividerThickness,
                              color: FlutterFlowTheme.of(context).primaryColor,
                            ),
                          ],
                        ),
                        OutlinedButton(
                          onPressed: () async {},
                          child: Text('ACCESS QUESTIONS'),
                          style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            foregroundColor:
                                FlutterFlowTheme.of(context).primaryColor,
                            fixedSize: const Size(165, Constants.mlMargin),
                            backgroundColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                            side: BorderSide(
                                width: 1,
                                color:
                                    FlutterFlowTheme.of(context).primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Question',
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Points',
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Score',
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Solution',
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        0, 0, 0, Constants.msMargin),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FutureBuilder<ApiCallResponse>(
                          future: ViewCall.call(
                            assignmentID: getJsonField(
                              widget.assignmentSum,
                              r'''$.id''',
                            ),
                            token: StoredPreferences.authToken,
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: CircularProgressIndicator(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                  ),
                                ),
                              );
                            }
                            final listViewViewResponse = snapshot.data!;
                            return Builder(
                              builder: (context) {
                                final questions = ViewCall.questions(
                                  listViewViewResponse.jsonBody,
                                ).toList();
                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: questions.length,
                                  itemBuilder: (context, questionsIndex) {
                                    final questionsItem =
                                        questions[questionsIndex];
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      onTap: () async {
                                        if (!_checkConnection()) return;
                                        setState(() => AppState().view =
                                            listViewViewResponse.jsonBody);
                                        setState(() => AppState().question =
                                            questionsItem);
                                        setState(() => AppState().isBasic =
                                                functions.isBasic(getJsonField(
                                              questionsItem,
                                              r'''$.technology_iframe''',
                                            ).toString()));
                                        setState(() => AppState()
                                                .hasSubmission = getJsonField(
                                              questionsItem,
                                              r'''$.has_at_least_one_submission''',
                                            ));
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                          context: context,
                                          builder: (context) {
                                            return Padding(
                                              padding: MediaQuery.of(context)
                                                  .viewInsets,
                                              child: Container(
                                                height: double.infinity,
                                                child: QuestionCTNWidget(
                                                  assignmentName: getJsonField(
                                                    widget.assignmentSum,
                                                    r'''$.name''',
                                                  ).toString(),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                                .fromSTEB(
                                            0, Constants.sMargin, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                functions
                                                    .addOne(questionsIndex)
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Open Sans',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryColor,
                                                    ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                getJsonField(
                                                  questionsItem,
                                                  r'''$.points''',
                                                ).toString(),
                                                textAlign: TextAlign.center,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'Open Sans',
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                getJsonField(
                                                  questionsItem,
                                                  r'''$.total_score''',
                                                ).toString(),
                                                textAlign: TextAlign.center,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'Open Sans',
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                functions.questionSolution(
                                                    getJsonField(
                                                  widget.assignmentSum,
                                                  r'''$.solution_exists''',
                                                )),
                                                textAlign: TextAlign.center,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'Open Sans',
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
