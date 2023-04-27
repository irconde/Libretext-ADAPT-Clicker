import 'package:adapt_clicker/components/connection_state_mixin.dart';
import 'package:adapt_clicker/components/assignment_grid_widget.dart';
import 'package:adapt_clicker/utils/stored_preferences.dart';
import 'package:auto_route/auto_route.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../utils/constants.dart';
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
                            padding: const EdgeInsetsDirectional.fromSTEB(Constants.xsMargin, Constants.sMargin, Constants.xsMargin, Constants.sMargin),
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
                                  style: theme
                                      .bodyText1
                                      .override(
                                    fontFamily: 'Open Sans',
                                    color: theme.primaryBackground,
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
                              Visibility(
                                visible: assignmentSummary['public_description'] != null,
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, Constants.msMargin),
                                  child: RichText(
                                    text: TextSpan(
                                      style: theme.bodyText3,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Description:  ',
                                          style: theme
                                              .bodyText3
                                              .override(
                                            fontFamily: 'Open Sans',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: assignmentSummary['public_description'] ?? 'There is no description',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: (assignmentSummary['formatted_late_policy'] != null || assignmentSummary['late_policy'] != null),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, Constants.smMargin),
                                  child: RichText(
                                    text: TextSpan(
                                      style: theme.bodyText3,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Late Policy: ',
                                          style: theme
                                              .bodyText3
                                              .override(
                                            fontFamily: 'Open Sans',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: assignmentSummary['formatted_late_policy'] ?? assignmentSummary['late_policy'].toString(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(Constants.sMargin),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                              final builderResponse = snapshot.data!;
                              return Builder(
                                builder: (context) {
                                  int gridViewCrossAxisCount = 3;
                                  final questions = ViewCall.questions(
                                    builderResponse.jsonBody,
                                  ).toList();
                                  return Container(
                                    color: Colors.black12,
                                    child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: gridViewCrossAxisCount,
                                        childAspectRatio: 1,
                                        mainAxisSpacing:
                                            2.0, // add this to add horizontal divider
                                        crossAxisSpacing:
                                            2.0, // add this to add vertical divider
                                      ),
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: itemCount(questions.length,
                                          gridViewCrossAxisCount), // add one more item to fill the space
                                      clipBehavior: Clip
                                          .none, // add this to prevent clipping of divider
                                      itemBuilder: (context, questionsIndex) {
                                        return questionsIndex ==
                                                questions
                                                    .length // check if the index is equal to the length of the list
                                            ? Container(
                                                color: theme.primaryBackground,
                                              ) // return an empty container
                                            : AssignmentGridWidget(
                                                questionsItem:
                                                    questions[questionsIndex],
                                                assignmentSummary:
                                                    assignmentSummary,
                                                ref: ref,
                                                builderResponse:
                                                    builderResponse,
                                                questionsIndex: questionsIndex,
                                              ); // otherwise return your widget
                                      },
                                    ),
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
            ),
          );
        });
  }

  itemCount(length, int gridViewCrossAxisCount) {
    if(length % gridViewCrossAxisCount == 0)
      return length;

    return length + (gridViewCrossAxisCount - (length % gridViewCrossAxisCount));
  }
}
