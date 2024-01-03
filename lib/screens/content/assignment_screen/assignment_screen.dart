import 'package:adapt_clicker/constants/icons.dart';
import 'package:adapt_clicker/mixins/connection_state_mixin.dart';
import 'package:adapt_clicker/screens/content/assignment_screen/assignment_grid_widget.dart';
import 'package:adapt_clicker/backend/user_stored_preferences.dart';
import 'package:adapt_clicker/widgets/shimmer/shim_pages.dart';
import 'package:auto_route/auto_route.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';
import '../../../backend/api_requests/api_calls.dart';
import '../../../constants/strings.dart';
import '../../../utils/logger.dart';
import '../../../utils/animations.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/utils.dart';
import '../../../constants/Dimens.dart';
import '../../../constants/colors.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AssignmentScreen extends ConsumerStatefulWidget {
  /// A widget representing the assignment screen.
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
    //setPluralAttempts();
  }


  @override
  Widget build(BuildContext context) {
    var theme = AppTheme.of(context);
    return isLoading
        ? shimQuestionList(setState: setState, context: context)
        : FutureBuilder(
            future: getSummary(),
            builder: (context, snapshot) {
              return Scaffold(
                backgroundColor: CColors.primaryBackground,
                appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: CColors.primaryBackground,
                  leading: IconButton(
                    icon: IIcons.close,
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
                        onPressed: () {
                          setState(() {
                            expansionController.expanded =
                                !expansionController.value;
                          });
                        },
                        icon: IIcons.info(expansionController.value),
                    ),
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
                          header: Container(
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                color: CColors.coursePagePullDown),
                            child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    Dimens.xsMargin,
                                    Dimens.sMargin,
                                    Dimens.xsMargin,
                                    Dimens.sMargin),
                                child: Align(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Chip(
                                          backgroundColor:
                                              CColors.secondaryColor,
                                          label: Text(
                                            "${assignmentSummary['total_points']} ${Strings.points}",
                                            style: theme.bodyText1.override(
                                              fontFamily: 'Open Sans',
                                              color: CColors.primaryBackground,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                                  .fromSTEB(Dimens.xsMargin, 0,
                                              Dimens.xsMargin, 0),
                                          child: Chip(
                                            backgroundColor:
                                                CColors.secondaryColor,
                                            label: Text(
                                              " ${assignmentSummary['number_of_allowed_attempts'] ?? 0} ${Strings.allowedAttempts}",
                                              style: theme.bodyText1.override(
                                                fontFamily: 'Open Sans',
                                                color:
                                                    CColors.primaryBackground,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Chip(
                                          backgroundColor:
                                              CColors.secondaryColor,
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(Dimens.xsMargin, 0, Dimens.xsMargin, 0),
                                          labelPadding:
                                              const EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, Dimens.xxsMargin, 0),
                                          avatar: IIcons.dateRange,
                                          label: Text(
                                            " ${formatDate(assignmentSummary['formatted_due'] ?? assignmentSummary['due']['due_date'])}",
                                            style: theme.bodyText1.override(
                                              fontFamily: 'Open Sans',
                                              color: CColors.primaryBackground,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                          expanded: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                color: CColors.coursePagePullDown),
                            child: Padding(
                              padding: const EdgeInsets.all(Dimens.msMargin),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Visibility(
                                    visible: assignmentSummary[
                                            'public_description'] !=
                                        null,
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, Dimens.msMargin),
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
                                  Visibility(
                                    visible: (assignmentSummary[
                                                'formatted_late_policy'] !=
                                            null ||
                                        assignmentSummary['late_policy'] !=
                                            null),
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, Dimens.smMargin),
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
                                        width: Dimens.llMargin,
                                        height: Dimens.llMargin,
                                        child: CircularProgressIndicator(
                                          color: CColors.primaryColor,
                                        ),
                                      ),
                                    );
                                  }
                                  final builderResponse = snapshot.data!;
                                  return Builder(builder: (context) {
                                    int gridViewCrossAxisCount = 3;
                                    final List<dynamic> questions =
                                        ViewCall.questions(
                                      builderResponse.jsonBody,
                                    )?.toList();
                                    createQuestionUrls(questions);

                                    if (questions.isNotEmpty) {
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

  //TODO: Fix this
  /*void setPluralAttempts() {
    int b = 0;
    if(assignmentSummary["number_of_allowed_attempts"] != null){
      b = int.parse(assignmentSummary['number_of_allowed_attempts']);}
    if (b == 1) {
      allowedAttempts = Strings.allowedAttempt;
      logger.log(Level.wtf, 'Rawr');
      return;
    }
  }*/
  void createQuestionUrls(List<dynamic> questions) {
    // create an empty list of strings to store the urls
    List<String> urls = [];

    // loop through each question in the list
    for (var question in questions) {
      // get the question id from the json
      var questionID = question['id'];

      // construct the url using string interpolation
      var url =
          '${Strings.adaptLink}/assignments/${AppState().assignmentId}/questions/view/$questionID';

      // add the url to the list
      urls.add(url);
    }

    AppState().urls = urls;
  }

  /// Retrieves the assignment summary from the widget and initializes the [assignmentSummary] variable.
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

  itemCount(length, int gridViewCrossAxisCount) {
    if (length % gridViewCrossAxisCount == 0) {
      return length;
    }
    var mod = (length % gridViewCrossAxisCount);
    logger.d('mod is $mod');
    var reverse = (gridViewCrossAxisCount - mod);
    logger.d('reverse is $reverse');
    var l = length + reverse;
    logger.d('l is $l');
    return l;
  }
}
