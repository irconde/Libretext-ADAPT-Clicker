import 'package:adapt_clicker/backend/user_stored_preferences.dart';
import 'package:adapt_clicker/widgets/dropdowns/assignment_dropdown_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../backend/api_requests/api_calls.dart';
import '../../constants/strings.dart';
import 'assignment_ctn_widget.dart';
import 'assignment_stat_ctn_widget.dart';
import '../../widgets/app_bars/collapsible_app_bar_widget.dart';
import '../../utils/app_theme.dart';
import '../../utils/utils.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../widgets/shimmer_widget.dart';
import '../../constants/dimens.dart';
import '../../constants/colors.dart';

@RoutePage()
class CourseDetailsScreen extends ConsumerStatefulWidget {
  const CourseDetailsScreen({
    Key? key,
    @PathParam('course') required this.id,
  }) : super(key: key);

  final String id;

  @override
  ConsumerState<CourseDetailsScreen> createState() =>
      _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends ConsumerState<CourseDetailsScreen> {
  final ScrollController _mainController = ScrollController();
  final ScrollController _learningTabController = ScrollController();
  final ScrollController _assignmentsTabController = ScrollController();

  late int id;
  late Map<String, dynamic> scores;
  Map<String, dynamic>? course;
  List<dynamic> assignmentsList = [];
  late ApiCallResponse scoreResponse;

  @override
  void initState() {
    id = int.parse(widget.id);
    super.initState();
    // On page load action.
    _currentFilterOption = _filterOptions[0];
    _currentOrderOption = _orderOptions.keys.toList()[0];
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() => AppState().assignmentUp = false);
    });
  }

  Future<ApiCallResponse?> getScores() async {
    scoreResponse = await GetScoresByUserCall.call(
        token: UserStoredPreferences.authToken, course: id);

    scores = scoreResponse.jsonBody;
    course = scores['course'];

    if (scores['assignments'] != null) {
      assignmentsList = scores['assignments'].toList();
    }

    return scoreResponse;
  }

  //Shimmer page (could be moved to own class if wanted)
  Widget buildFoodShimmer() {
    return Column(
      children: [
        ShimmerWidget.rectangular(
          height: MediaQuery.of(context).size.height,
          backgroundColor: CColors.shadowGrey,
          shimmerColor: CColors.primaryBackground,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CColors.primaryBackground,
        body: FutureBuilder(
            future: getScores(),
            builder: (context, snapshot) {
              return course == null ? buildFoodShimmer() : loadedPage(context);
            }));
  }

  //Actual Page
  Widget loadedPage(BuildContext context) {
    var theme = AppTheme.of(context);
    return NestedScrollView(
      controller: _mainController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          CollapsibleAppBar(
            showNotificationIcon: true,
            title: course?['name'] ?? Strings.noCourseName,
            iconPath: 'assets/images/libretexts_logo.svg',
          ),
        ];
      },
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Material(
                color: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: CColors.primaryColor,
                    borderRadius: BorderRadius.circular(0),
                    border: Border.all(
                      color: CColors.primaryColor,
                      width: 0,
                    ),
                  ),
                  child: DefaultTabController(
                    length: 2,
                    initialIndex: 0,
                    child: Column(
                      children: [
                        TabBar(
                          labelColor: CColors.primaryBackground,
                          unselectedLabelColor: CColors.unselectedLabel,
                          labelStyle: theme.bodyText1,
                          indicatorColor: CColors.primaryBackground,
                          tabs: const [
                            Tab(
                              text: Strings.homeTab,
                            ),
                            Tab(
                              text: Strings.assignmentsTab,
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: CColors.primaryBackground,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      color: CColors.coursePagePullDown,
                                      child: ExpandableNotifier(
                                        initialExpanded: false,
                                        child: ExpandablePanel(
                                          header: Container(
                                            alignment: Alignment.centerLeft,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 116,
                                            decoration: const BoxDecoration(
                                                color:
                                                    CColors.coursePagePullDown),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                      Dimens.mmMargin,
                                                      Dimens.msMargin,
                                                      0,
                                                      Dimens.msMargin),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(0, 0,
                                                            0, Dimens.msMargin),
                                                    child: RichText(
                                                      text: TextSpan(
                                                          style: theme.bodyText1
                                                              .override(
                                                                  fontFamily:
                                                                      'Open Sans',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: CColors
                                                                      .tertiaryText),
                                                          children: [
                                                            const TextSpan(
                                                                text:
                                                                    'Instructor: '),
                                                            TextSpan(
                                                              text: course?[
                                                                      'instructor'] ??
                                                                  Strings
                                                                      .noCourseInstructor,
                                                              style: theme
                                                                  .bodyText1
                                                                  .override(
                                                                color: CColors
                                                                    .tertiaryText,
                                                                fontFamily:
                                                                    'Open Sans',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                            ),
                                                          ]),
                                                    ),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      style: theme.bodyText1
                                                          .override(
                                                        fontFamily: 'Open Sans',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: CColors
                                                            .tertiaryText,
                                                      ),
                                                      children: <TextSpan>[
                                                        const TextSpan(
                                                          text:
                                                              Strings.startDate,
                                                        ),
                                                        TextSpan(
                                                          text: formatDate(course?[
                                                                  'start_date'] ??
                                                              Strings.noDate),
                                                          style: theme.bodyText1
                                                              .override(
                                                            fontFamily:
                                                                'Open Sans',
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: CColors
                                                                .tertiaryText,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          collapsed: Container(
                                              color:
                                                  CColors.coursePagePullDown),
                                          expanded: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: const BoxDecoration(
                                              color: CColors.coursePagePullDown,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          Dimens.mmMargin,
                                                          0,
                                                          0,
                                                          Dimens.msMargin),
                                                  child: RichText(
                                                    text: TextSpan(
                                                      style: theme.bodyText1
                                                          .override(
                                                        fontFamily: 'Open Sans',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: CColors
                                                            .tertiaryText,
                                                      ),
                                                      children: <TextSpan>[
                                                        const TextSpan(
                                                          text: Strings.endDate,
                                                        ),
                                                        TextSpan(
                                                          text: formatDate(course?[
                                                                  'end_date'] ??
                                                              Strings.noDate),
                                                          style: theme.bodyText1
                                                              .override(
                                                            fontFamily:
                                                                'Open Sans',
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: CColors
                                                                .tertiaryText,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                  visible:
                                                      course?['description'] !=
                                                          null,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            Dimens.mmMargin,
                                                            0,
                                                            0,
                                                            Dimens.msMargin),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        style: theme.bodyText1
                                                            .override(
                                                          fontFamily:
                                                              'Open Sans',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: CColors
                                                              .tertiaryText,
                                                        ),
                                                        children: <TextSpan>[
                                                          const TextSpan(
                                                            text: Strings
                                                                .description,
                                                          ),
                                                          TextSpan(
                                                            text: course?[
                                                                'description'],
                                                            style: theme
                                                                .bodyText1
                                                                .override(
                                                              fontFamily:
                                                                  'Open Sans',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: CColors
                                                                  .tertiaryText,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          theme: const ExpandableThemeData(
                                            tapHeaderToExpand: true,
                                            tapBodyToExpand: true,
                                            tapBodyToCollapse: false,
                                            headerAlignment:
                                                ExpandablePanelHeaderAlignment
                                                    .center,
                                            hasIcon: true,
                                            expandIcon:
                                                Icons.keyboard_arrow_down,
                                            collapseIcon:
                                                Icons.keyboard_arrow_up,
                                            iconSize: Dimens.llMargin,
                                            iconPadding: EdgeInsets.fromLTRB(
                                                0, 0, 20, 0),
                                            iconColor: CColors.tertiaryText,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        color: CColors.secondaryBackground,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(32, 24, 24, 24),
                                        child: Text(
                                          Strings.learningProcess,
                                          style: theme.bodyText1.override(
                                            fontFamily: 'Open Sans',
                                            fontWeight: FontWeight.bold,
                                            color: CColors.tertiaryText,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      fit: FlexFit.tight,
                                      child: ScrollShadow(
                                          controller: _learningTabController,
                                          child: ListView.builder(
                                              padding: const EdgeInsets.all(0),
                                              controller:
                                                  _learningTabController,
                                              itemCount: assignmentsList.length,
                                              itemBuilder: (context, index) {
                                                dynamic assignment =
                                                    assignmentsList[index];
                                                if (assignment != null &&
                                                    assignment['past_due'] !=
                                                        null &&
                                                    !assignment['past_due']) {
                                                  return AssignmentStatCtnWidget(
                                                    assignment: assignment,
                                                  );
                                                }
                                              })),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: const BoxDecoration(
                                  color: CColors.primaryBackground,
                                  shape: BoxShape.rectangle,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 100,
                                      decoration: const BoxDecoration(
                                        color: CColors.coursePagePullDown,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          AssignmentDropdown(
                                            dropDownValue: _currentFilterOption,
                                            itemList: _filterOptions,
                                            onItemSelectedCallback:
                                                onFilterOptionSelected,
                                          ),
                                          AssignmentDropdown(
                                            dropDownValue: _currentOrderOption,
                                            itemList:
                                                _orderOptions.keys.toList(),
                                            onItemSelectedCallback:
                                                onOrderOptionSelected,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: ScrollShadow(
                                        controller: _assignmentsTabController,
                                        child: SingleChildScrollView(
                                          controller: _assignmentsTabController,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Builder(
                                                builder: (context) {
                                                  final filteredAssignmentList =
                                                      orderAssignmentList(
                                                          filterAssignmentList(
                                                              jsonToAssignmentList(
                                                                  scoreResponse),
                                                              _currentFilterOption!),
                                                          _currentOrderOption!);
                                                  return ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount:
                                                        filteredAssignmentList
                                                            .length,
                                                    itemBuilder: (context,
                                                        assignmentsIndex) {
                                                      final assignmentsItem =
                                                          filteredAssignmentList[
                                                              assignmentsIndex];

                                                      return AssignmentCtnWidget(
                                                          assignmentsItem:
                                                              (assignmentsItem));
                                                    },
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _currentFilterOption;
  String? _currentOrderOption;
  final List<String> _filterOptions = [
    Strings.filterAllAssignments,
    Strings.filterExam,
    Strings.filterExtraCredit,
    Strings.filterHomework,
    Strings.filterLab
  ];

  final _orderOptions = {
    Strings.orderName: 'name',
    Strings.orderStartDate: 'available_from',
    Strings.orderDueDate: 'due'
  };

  // Define a function that takes a date string and returns a formatted string
  String formatDate(String date) {
    // Parse the date string using the given format
    DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
    // Format the date using the desired format
    String formattedDate = DateFormat('MM/d/yy').format(parsedDate);
    // Return the formatted date
    return formattedDate;
  }

  List jsonToAssignmentList(ApiCallResponse snapshot) =>
      GetScoresByUserCall.assignments(
        snapshot.jsonBody,
      ).toList(); // We already make this call on this page, why do we need it twice?

  List<dynamic> filterAssignmentList(List<dynamic> list, String filter) {
    if (filter == _filterOptions[0]) return list;
    List outputList = list
        .where((o) => equalsIgnoreCase(o['assignment_group'], filter))
        .toList();
    return outputList;
  }

  List<dynamic> orderAssignmentList(List<dynamic> list, String orderFactor) {
    String? refProperty = _orderOptions[orderFactor];
    list.sort((a, b) {
      dynamic c1;
      dynamic c2;
      switch (refProperty) {
        case 'name':
          c1 = a[refProperty];
          c2 = b[refProperty];
          break;
        case 'due':
          c1 = DateTime.parse(a[refProperty]['due_date']);
          c2 = DateTime.parse(b[refProperty]['due_date']);
          break;
        case 'available_from':
          c1 = DateTime.parse(a[refProperty]);
          c2 = DateTime.parse(b[refProperty]);
          break;
      }
      return c1.compareTo(c2);
    });
    return list;
  }

  void onFilterOptionSelected(filterOption) {
    setState(() {
      _currentFilterOption = filterOption;
    });
  }

  void onOrderOptionSelected(orderOption) {
    setState(() {
      _currentOrderOption = orderOption;
    });
  }
}
