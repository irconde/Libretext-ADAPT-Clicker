import 'package:adapt_clicker/mixins/connection_state_mixin.dart';
import 'package:adapt_clicker/screens/assignment_screen/assignment_grid_widget.dart';
import 'package:adapt_clicker/backend/user_stored_preferences.dart';
import 'package:adapt_clicker/widgets/shimmer/shim_pages.dart';
import 'package:auto_route/auto_route.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';
import 'package:logger/logger.dart';
import '../../backend/api_requests/api_calls.dart';
import '../../constants/strings.dart';
import '../../utils/Logger.dart';
import '../../utils/animations.dart';
import '../../utils/app_theme.dart';
import '../../utils/utils.dart';
import '../../constants/dimens.dart';
import '../../constants/colors.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AssignmentScreen extends ConsumerStatefulWidget {
  /// A widget representing the assignment screen.
  ///
  /// The [assignmentSum] represents the assignment summary.
  const AssignmentScreen({
    Key? key,
    @PathParam('summary') required this.assignmentSum,
  }) : super(key: key);

  final dynamic assignmentSum;

  @override
  ConsumerState<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends ConsumerState<AssignmentScreen>
    with TickerProviderStateMixin, ConnectionStateMixin {
  late Map<String, dynamic> assignmentSummary;
  bool isLoading = true;
  late Future<ApiCallResponse> viewCall;
  String allowedAttempts = "";

  final animationsMap = {
    'textOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      duration: 600,
      hideBeforeAnimating: false,
      initialState: const AnimationState(
        offset: Offset(0, 0),
        scale: 1,
        opacity: 0,
      ),
      finalState: const AnimationState(
        offset: Offset(0, 0),
        scale: 1,
        opacity: 1,
      ),
    ),
  };

  /// Formats the given [date] string into a formatted date string.
  ///
  /// The [date] string is parsed using the format 'yyyy-MM-dd HH:mm:ss',
  /// and the formatted date string is returned using the format 'MMMM d'.
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
    viewCall = getViewCall();
    setPluralAttempts();
  }

  void setPluralAttempts() {

    int b = int.parse(assignmentSummary['number_of_allowed_attempts']);
    if(b == 1) {
      allowedAttempts = Strings.allowedAttempt;
      logger.log(Level.wtf, 'Rawr');
      return;
    }

    allowedAttempts = Strings.allowedAttempts;


    logger.log(Level.warning, assignmentSummary['number_of_allowed_attempts'] + allowedAttempts);


  }
  /// Retrieves the assignment summary from the widget and initializes the [assignmentSummary] variable.
  ///
  /// If the [assignmentSum] is of type [String], it is decoded and parsed as JSON.
  Future<void> getSummary() async {
    if (widget.assignmentSum.runtimeType == String) {
      String decodedString = Uri.decodeComponent(widget.assignmentSum);
      assignmentSummary = jsonDecode(decodedString);
      logger.d('Assignment Summary : $assignmentSummary');
    } else {
      assignmentSummary = widget.assignmentSum;
    }
  }

  /// Retrieves the view call for the assignment.
  ///
  /// It calls the [ViewCall.call] method with the assignment ID and authentication token,
  /// and sets the [isLoading] flag to false once the response is received.
  Future<ApiCallResponse> getViewCall() async {
    await getSummary();
    var response = await ViewCall.call(
      assignmentID: assignmentSummary['id'],
      token: UserStoredPreferences.authToken,
    );
    setState(() {
      logger.d('IsLoading set');
      isLoading = false;
    });
    return response;
  }

  ExpandableController expansionController = ExpandableController();

  @override
  Widget build(BuildContext context) {
    var theme = AppTheme.of(context);
    return isLoading
        ? shimQuestionList(setState: setState, context: context)
        : FutureBuilder(
            future: getSummary(),
            builder: (context, snapshot) {
              return Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: CColors.primaryBackground,
                appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: CColors.primaryBackground,
                  elevation: 0.0,
                  leading: IconButton(
                    tooltip: Strings.closeButtonSemanticsLabel,
                    icon: const Icon(
                      Icons.close,
                      color: CColors.tertiaryColor,
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
                        color: CColors.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  actions: [
                    IconButton(
                      tooltip:  expansionController.value ? Strings.assignmentInfoOpenSemanticsLabel : Strings.assignmentInfoClosedSemanticsLabel,
                        onPressed: () {
                          setState(() {
                            expansionController.expanded =
                                !expansionController.value;
                          });
                        },
                        icon: Icon(
                          expansionController.value
                              ? Icons.info
                              : Icons.info_outline,
                          color: CColors.primaryColor,
                        )),
                  ],
                ),
                body: ScrollShadow(
                  color: CColors.shadowGrey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Divider(
                          thickness: Dimens.dividerThickness,
                          height: 1,
                        ),
                        ExpandablePanel(
                          controller: expansionController,
                          collapsed: Container(),
                          theme: const ExpandableThemeData(
                            hasIcon: false,
                          ),
                          header: Container(),
                          expanded: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                color: CColors.coursePagePullDown),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 24, 0, 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(
                                        color: CColors.coursePagePullDown),
                                    child: Padding(
                                        padding: const EdgeInsetsDirectional
                                                .fromSTEB(
                                            Dimens.xsMargin,
                                            Dimens.sMargin,
                                            Dimens.xsMargin,
                                            Dimens.sMargin),
                                        child: Align(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                Semantics(
                                                  label: "${assignmentSummary['total_points']} ${Strings.totalPointsSemanticsLabel}",
                                                  child: ExcludeSemantics(
                                                    child: Chip(
                                                      backgroundColor:
                                                          CColors.secondaryColor,
                                                      label: Text(
                                                        "${assignmentSummary['total_points']} ${Strings.points}",
                                                        style: theme.bodyText1
                                                            .override(
                                                          fontFamily: 'Open Sans',
                                                          color: CColors
                                                              .primaryBackground,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          Dimens.xsMargin,
                                                          0,
                                                          Dimens.xsMargin,
                                                          0),
                                                  child: Semantics(
                                                    label: " ${assignmentSummary['number_of_allowed_attempts'] ?? 0} $allowedAttempts",
                                                    child: ExcludeSemantics(
                                                      child: Chip(
                                                        backgroundColor:
                                                            CColors.secondaryColor,
                                                        label: Text(
                                                          " ${assignmentSummary['number_of_allowed_attempts'] ?? 0} $allowedAttempts",
                                                          style: theme.bodyText1
                                                              .override(
                                                            fontFamily: 'Open Sans',
                                                            color: CColors
                                                                .primaryBackground,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Semantics(
                                                  label: formatDate(assignmentSummary['formatted_due'] ?? assignmentSummary['due']['due_date']),
                                                  child: ExcludeSemantics(
                                                    child: Chip(
                                                      backgroundColor:
                                                          CColors.secondaryColor,
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(8, 0, 8, 0),
                                                      labelPadding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(0, 0, 4, 0),
                                                      avatar: const Icon(
                                                        Icons.date_range,
                                                        color: CColors
                                                            .primaryBackground,
                                                      ),
                                                      label: Text(
                                                        " ${formatDate(assignmentSummary['formatted_due'] ?? assignmentSummary['due']['due_date'])}",
                                                        style: theme.bodyText1
                                                            .override(
                                                          fontFamily: 'Open Sans',
                                                          color: CColors
                                                              .primaryBackground,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child: Visibility(
                                      visible: assignmentSummary[
                                              'public_description'] !=
                                          null,
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, Dimens.msMargin),
                                        child: RichText(
                                          text: TextSpan(
                                            style: theme.bodyText3,
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: Strings.description,
                                                style: theme.bodyText3.override(
                                                  fontFamily: 'Open Sans',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text: assignmentSummary[
                                                        'public_description'] ??
                                                    Strings.noDescription,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child: Visibility(
                                      visible: (assignmentSummary[
                                                  'formatted_late_policy'] !=
                                              null ||
                                          assignmentSummary['late_policy'] !=
                                              null),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, Dimens.smMargin),
                                        child: RichText(
                                          text: TextSpan(
                                            style: theme.bodyText3,
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: Strings.latePolicy,
                                                style: theme.bodyText3.override(
                                                  fontFamily: 'Open Sans',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text: assignmentSummary[
                                                        'formatted_late_policy'] ??
                                                    assignmentSummary[
                                                            'late_policy']
                                                        .toString(),
                                              ),
                                            ],
                                          ),
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
                          padding: const EdgeInsets.all(Dimens.smMargin),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FutureBuilder<ApiCallResponse>(
                                future: viewCall,
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return const Center(
                                      child: SizedBox(
                                        width: 48,
                                        height: 48,
                                        child: CircularProgressIndicator(
                                          color: CColors.primaryColor,
                                        ),
                                      ),
                                    );
                                  }
                                  final builderResponse = snapshot.data!;
                                  return Builder(builder: (context) {
                                    int gridViewCrossAxisCount = 3;
                                    final questions = ViewCall.questions(
                                      builderResponse.jsonBody,
                                    )?.toList();

                                    if (questions.length != 0) {
                                      bool spacing = true;
                                      if (questions.length == 1) {
                                        spacing = false;
                                      }
                                      return Container(
                                        color: Colors.black12,
                                        child: GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount:
                                                gridViewCrossAxisCount,
                                            childAspectRatio: 1,
                                            mainAxisSpacing: spacing ? 2.0 : 0,
                                            crossAxisSpacing: spacing ? 2.0 : 0,
                                          ),
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,

                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: itemCount(questions.length,
                                              gridViewCrossAxisCount),
                                          // add more items to fill the space
                                          clipBehavior: Clip.none,
                                          itemBuilder:
                                              (context, questionsIndex) {
                                            return questionsIndex >=
                                                    questions
                                                        .length // check if the index is equal to the length of the list
                                                ? Container(
                                                    color: CColors
                                                        .primaryBackground,
                                                  ) // return an empty container
                                                : AssignmentGridWidget(
                                                    questionsItem: questions[
                                                        questionsIndex],
                                                    assignmentSummary:
                                                        assignmentSummary,
                                                    ref: ref,
                                                    builderResponse:
                                                        builderResponse,
                                                    questionsIndex:
                                                        questionsIndex,
                                                  ); // otherwise return your widget
                                          },
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  });
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

  /// Calculates the item count for the GridView based on the length of the list of questions and the grid view's cross-axis count.
  ///
  /// The [length] represents the length of the list of questions.
  /// The [gridViewCrossAxisCount] represents the cross-axis count of the GridView.
  ///
  /// If the length is divisible by the cross-axis count, the length is returned as the item count.
  /// Otherwise, the item count is calculated by adding the difference between the cross-axis count and the modulo of length and cross-axis count to the length.
  itemCount(length, int gridViewCrossAxisCount) {
    if (length % gridViewCrossAxisCount == 0) {
      return length;
    }
    var mod = (length % gridViewCrossAxisCount);
    //logger.d('mod is $mod');
    var reverse = (gridViewCrossAxisCount - mod);
    //logger.d('reverse is $reverse');
    var l = length + reverse;
    //logger.d('l is $l');
    return l;
  }
}
