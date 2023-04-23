import 'package:adapt_clicker/components/connection_state_mixin.dart';
import 'package:adapt_clicker/utils/stored_preferences.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';
import '../backend/api_requests/api_calls.dart';
import '../components/question_c_t_n_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../utils/constants.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import '../utils/check_internet_connectivity.dart';

@RoutePage()
class AssignmentDetailsWidget extends ConsumerStatefulWidget {
  const AssignmentDetailsWidget({
    Key? key,
    @PathParam('summary') required this.assignmentSum,
  }) : super(key: key);

  final dynamic assignmentSum;

  @override
  ConsumerState<AssignmentDetailsWidget> createState() =>
      _AssignmentDetailsWidgetState();
}

class _AssignmentDetailsWidgetState
    extends ConsumerState<AssignmentDetailsWidget>
    with TickerProviderStateMixin, ConnectionStateMixin {

  late Map<String, dynamic> assignmentSummary;

  @override
  void initState() {
    super.initState();
  }

  Future<void> getSummary() async {
    if(widget.assignmentSum.runtimeType == String) {
      String decodedString = Uri.decodeComponent(widget.assignmentSum);
      assignmentSummary = jsonDecode(decodedString);
      //print('Assignment Summary : $assignmentSummary');
    }else {
      assignmentSummary = widget.assignmentSum;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getSummary(),
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme
                .of(context)
                .primaryBackground,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: FlutterFlowTheme
                  .of(context)
                  .primaryBackground,
              elevation: 0.0,
              leading: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.grey,
                ),
                onPressed: () {
                  context.popRoute();
                },
              ),
              title: Text(
                assignmentSummary['name'],
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: FlutterFlowTheme
                    .of(context)
                    .bodyText1
                    .override(
                    fontFamily: 'Open Sans',
                    color: FlutterFlowTheme
                        .of(context)
                        .primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
            body: ScrollShadow(
              color: FlutterFlowTheme
                  .of(context)
                  .shadowGrey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Divider(
                      indent: Constants.mmMargin,
                      endIndent: Constants.mmMargin,
                      thickness: Constants.dividerThickness,
                      height: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(Constants.mmMargin),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, Constants.msMargin),
                            child: RichText(
                              text: TextSpan(
                                style:
                                FlutterFlowTheme
                                    .of(context)
                                    .bodyText1
                                    .override(
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w600,
                                ),
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: 'Number of Points: ',
                                  ),
                                  TextSpan(
                                    text: "This assignment is worth a total of ${assignmentSummary['total_points']} points",
                                    style: FlutterFlowTheme
                                        .of(context)
                                        .bodyText1
                                        .override(
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, Constants.msMargin),
                            child: RichText(
                              text: TextSpan(
                                  style:
                                  FlutterFlowTheme
                                      .of(context)
                                      .bodyText1
                                      .override(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: 'Number of Questions: ',
                                    ),
                                    TextSpan(
                                      text: "This assignment has ${assignmentSummary['.number_of_questions']} questions",
                                      style: FlutterFlowTheme
                                          .of(context)
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, Constants.msMargin),
                            child: RichText(
                              text: TextSpan(
                                style:
                                FlutterFlowTheme
                                    .of(context)
                                    .bodyText1
                                    .override(
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [
                                  const TextSpan(
                                    text: 'Due Date: ',
                                  ),
                                  TextSpan(
                                    text: "This assignment is due by ${assignmentSummary['formatted_due']}",
                                    style: FlutterFlowTheme
                                        .of(context)
                                        .bodyText1
                                        .override(
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: FlutterFlowTheme
                                  .of(context)
                                  .bodyText1,
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Late Policy: ',
                                  style: FlutterFlowTheme
                                      .of(context)
                                      .bodyText1
                                      .override(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: assignmentSummary['formatted_late_policy'].toString(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            child: Stack(
                              alignment: const AlignmentDirectional(0, 0),
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Divider(
                                      thickness: Constants.dividerThickness,
                                      color:
                                      FlutterFlowTheme
                                          .of(context)
                                          .primaryColor,
                                    ),
                                  ],
                                ),
                                OutlinedButton(
                                  onPressed: () async {
                                    // TODO. Implement this
                                  },
                                  style: ElevatedButton.styleFrom(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    foregroundColor:
                                    FlutterFlowTheme
                                        .of(context)
                                        .primaryColor,
                                    fixedSize: const Size(
                                        165, Constants.mlMargin),
                                    backgroundColor: FlutterFlowTheme
                                        .of(context)
                                        .primaryBackground,
                                    side: BorderSide(
                                        width: 1,
                                        color: FlutterFlowTheme
                                            .of(context)
                                            .primaryColor),
                                  ),
                                  child: const Text('ACCESS QUESTIONS'),
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
                                  FlutterFlowTheme
                                      .of(context)
                                      .bodyText1
                                      .override(
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
                                  FlutterFlowTheme
                                      .of(context)
                                      .bodyText1
                                      .override(
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
                                  FlutterFlowTheme
                                      .of(context)
                                      .bodyText1
                                      .override(
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
                                  FlutterFlowTheme
                                      .of(context)
                                      .bodyText1
                                      .override(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, Constants.msMargin),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                FutureBuilder<ApiCallResponse>(
                                  future: ViewCall.call(
                                    assignmentID:  assignmentSummary['id'],
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
                                            color: FlutterFlowTheme
                                                .of(context)
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
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: questions.length,
                                          itemBuilder: (context,
                                              questionsIndex) {
                                            final questionsItem =
                                            questions[questionsIndex];
                                            return InkWell(
                                              splashColor: Colors.transparent,
                                              onTap: () async {
                                                if (!checkConnection()) return;
                                                setState(() =>
                                                AppState().view =
                                                    listViewViewResponse
                                                        .jsonBody);
                                                setState(() =>
                                                AppState().question =
                                                    questionsItem);
                                                setState(() =>
                                                AppState().isBasic =
                                                    functions
                                                        .isBasic(getJsonField(
                                                      questionsItem,
                                                      r'''$.technology_iframe''',
                                                    ).toString()));
                                                setState(() =>
                                                AppState()
                                                    .hasSubmission =
                                                    getJsonField(
                                                      questionsItem,
                                                      r'''$.has_at_least_one_submission''',
                                                    ));
                                                await showModalBottomSheet(
                                                  useSafeArea: true,
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                  FlutterFlowTheme
                                                      .of(context)
                                                      .primaryBackground,
                                                  context: context,
                                                  builder: (context) {
                                                    return Padding(
                                                      padding: MediaQuery
                                                          .of(context)
                                                          .viewInsets,
                                                      child: SizedBox(
                                                        height: double.infinity,
                                                        child: QuestionCTNWidget(
                                                          assignmentName: assignmentSummary['name'],
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
                                                  mainAxisSize: MainAxisSize
                                                      .max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        functions
                                                            .addOne(
                                                            questionsIndex)
                                                            .toString(),
                                                        textAlign: TextAlign
                                                            .center,
                                                        style: FlutterFlowTheme
                                                            .of(
                                                            context)
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Open Sans',
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color:
                                                          FlutterFlowTheme
                                                              .of(
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
                                                        textAlign: TextAlign
                                                            .center,
                                                        style: FlutterFlowTheme
                                                            .of(
                                                            context)
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Open Sans',
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
                                                        textAlign: TextAlign
                                                            .center,
                                                        style: FlutterFlowTheme
                                                            .of(
                                                            context)
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Open Sans',
                                                          fontWeight:
                                                          FontWeight.normal,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        functions
                                                            .questionSolution(assignmentSummary['solution_exist']),
                                                        textAlign: TextAlign
                                                            .center,
                                                        style: FlutterFlowTheme
                                                            .of(
                                                            context)
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Open Sans',
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
            ),
          );
        }
    );
  }
}
