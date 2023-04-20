import 'package:adapt_clicker/components/connection_state_mixin.dart';
import 'package:adapt_clicker/utils/stored_preferences.dart';
import 'package:auto_route/auto_route.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';
import '../backend/api_requests/api_calls.dart';
import '../components/question_c_t_n_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../utils/constants.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';

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
  final animationsMap = {
    'textOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      duration: 600,
      hideBeforeAnimating: false,
      initialState: AnimationState(
        offset: const Offset(0, 0),
        scale: 1,
        opacity: 0,
      ),
      finalState: AnimationState(
        offset: const Offset(0, 0),
        scale: 1,
        opacity: 1,
      ),
    ),
  };

  // Define a function that takes a date string and returns a formatted string
  String formatDate(String date) {
    // Parse the date string using the given format
    DateTime parsedDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(date);
    // Format the date using the desired format
    String formattedDate = DateFormat('MMMM d').format(parsedDate);
    // Return the formatted date
    return formattedDate;
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> getSummary() async {
    if (widget.assignmentSum.runtimeType == String) {
      String decodedString = Uri.decodeComponent(widget.assignmentSum);
      assignmentSummary = jsonDecode(decodedString);
      //print('Assignment Summary : $assignmentSummary');
    } else {
      assignmentSummary = widget.assignmentSum;
    }
  }

  ExpandableController expansionController = ExpandableController();

  @override
  Widget build(BuildContext context) {
    var theme = FlutterFlowTheme.of(context);
    return FutureBuilder(
        future: getSummary(),
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: theme.primaryBackground,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: theme.primaryBackground,
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
                style: theme.bodyText1.override(
                    fontFamily: 'Open Sans',
                    color: theme.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        expansionController.expanded =
                            !expansionController.value;
                      });
                    },
                    icon: Icon(
                      Icons.info,
                      color: theme.primaryColor,
                    )),
              ],
            ),
            body: ScrollShadow(
              color: theme.shadowGrey,
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
                    ExpandablePanel(
                      controller: expansionController,
                      collapsed: Container(),
                      theme: const ExpandableThemeData(
                        hasIcon: false,
                      ),
                      header: Container(
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width,
                        decoration:
                            BoxDecoration(color: theme.coursePagePullDown),
                        child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Align(
                              child: Wrap(
                                direction: Axis.horizontal,
                                spacing: 4,
                                alignment: WrapAlignment.start,
                                children: [
                                  Chip(
                                    backgroundColor: theme.secondaryColor,
                                    label: Text(
                                      " ${assignmentSummary['total_points']} points",
                                      style: theme.bodyText1.override(
                                        fontFamily: 'Open Sans',
                                        color: theme.primaryBackground,
                                      ),
                                    ),
                                  ),
                                  Chip(
                                    backgroundColor: theme.secondaryColor,
                                    label: Text(
                                      " ${assignmentSummary['number_of_allowed_attempts'] ?? 0} allowed attempts",
                                      style: theme.bodyText1.override(
                                        fontFamily: 'Open Sans',
                                        color: theme.primaryBackground,
                                      ),
                                    ),
                                  ),
                                  Chip(
                                    backgroundColor: theme.secondaryColor,
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            8, 0, 8, 0),
                                    labelPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 4, 0),
                                    avatar: Icon(
                                      Icons.date_range,
                                      color: theme.primaryBackground,
                                    ),
                                    label: Text(
                                      " ${formatDate(assignmentSummary['formatted_due'] ?? assignmentSummary['due']['due_date'])}",
                                      style: theme.bodyText1.override(
                                        fontFamily: 'Open Sans',
                                        color: theme.primaryBackground,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      expanded: Container(
                        alignment: Alignment.topLeft,
                        width: MediaQuery.of(context).size.width,
                        decoration:
                            BoxDecoration(color: theme.coursePagePullDown),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, Constants.msMargin),
                                child: RichText(
                                  text: TextSpan(
                                    style: theme.bodyText3,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Public Description:  ',
                                        style: theme.bodyText3.override(
                                          fontFamily: 'Open Sans',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: assignmentSummary[
                                                'public_description'] ??
                                            'There is no description',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: theme.bodyText3,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Late Policy: ',
                                      style: theme.bodyText3.override(
                                        fontFamily: 'Open Sans',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: assignmentSummary[
                                              'formatted_late_policy'] ??
                                          assignmentSummary['late_policy']
                                              .toString(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(Constants.mmMargin),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Question',
                                  textAlign: TextAlign.center,
                                  style: theme.bodyText1.override(
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
                                  style: theme.bodyText1.override(
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
                                  style: theme.bodyText1.override(
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
                                  style: theme.bodyText1.override(
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
                                    assignmentID: assignmentSummary['id'],
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
                                            color: theme.primaryColor,
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
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: questions.length,
                                          itemBuilder:
                                              (context, questionsIndex) {
                                            final questionsItem =
                                                questions[questionsIndex];
                                            return InkWell(
                                              splashColor: Colors.transparent,
                                              onTap: () async {
                                                if (!checkConnection()) return;
                                                setState(() => AppState().view =
                                                    listViewViewResponse
                                                        .jsonBody);
                                                setState(() => AppState()
                                                    .question = questionsItem);
                                                setState(() =>
                                                    AppState().isBasic =
                                                        functions.isBasic(
                                                            getJsonField(
                                                      questionsItem,
                                                      r'''$.technology_iframe''',
                                                    ).toString()));
                                                setState(() =>
                                                    AppState().hasSubmission =
                                                        getJsonField(
                                                      questionsItem,
                                                      r'''$.has_at_least_one_submission''',
                                                    ));
                                                await showModalBottomSheet(
                                                  useSafeArea: true,
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryBackground,
                                                  context: context,
                                                  builder: (context) {
                                                    return Padding(
                                                      padding:
                                                          MediaQuery.of(context)
                                                              .viewInsets,
                                                      child: SizedBox(
                                                        height: double.infinity,
                                                        child:
                                                            QuestionCTNWidget(
                                                          assignmentName:
                                                              assignmentSummary[
                                                                  'name'],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                        0,
                                                        Constants.sMargin,
                                                        0,
                                                        0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
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
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Open Sans',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: FlutterFlowTheme.of(
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
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Open Sans',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
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
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Open Sans',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        functions.questionSolution(
                                                            assignmentSummary[
                                                                'solution_exist']),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Open Sans',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
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
        });
  }
}
