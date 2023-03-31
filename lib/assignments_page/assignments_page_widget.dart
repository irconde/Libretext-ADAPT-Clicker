import 'package:adapt_clicker/utils/stored_preferences.dart';
import 'package:adapt_clicker/components/assignment_dropdown.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/api_requests/api_calls.dart';
import '../components/assignment_ctn.dart';
import '../components/assignment_stat_ctn_widget.dart';
import '../components/collapsing_libre_app_bar.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../gen/assets.gen.dart';
import '../flutter_flow/custom_functions.dart' as functions;

class AssignmentsPageWidget extends ConsumerStatefulWidget {
  const AssignmentsPageWidget({
    Key? key,
    this.courseNumber,
    this.course,
  }) : super(key: key);

  final int? courseNumber;
  final dynamic course;

  @override
  ConsumerState<AssignmentsPageWidget> createState() =>
      _AssignmentsPageWidgetState();
}

class _AssignmentsPageWidgetState extends ConsumerState<AssignmentsPageWidget> {
  final ScrollController _mainController = ScrollController();
  final ScrollController _learningTabController = ScrollController();
  final ScrollController _assignmentsTabController = ScrollController();
  String? _currentFilterOption;
  String? _currentOrderOption;
  final List<String> _filterOptions = [
    'ALL ASSIGNMENTS',
    'EXAM',
    'EXTRA CREDIT',
    'HOMEWORK',
    'LAB'
  ];
  final _orderOptions = {
    'ORDER BY: NAME': 'name',
    'ORDER BY: START DATE': 'available_from',
    'ORDER BY: DUE DATE': 'due'
  };

  @override
  void initState() {
    super.initState();
    // On page load action.
    _currentFilterOption = _filterOptions[0];
    _currentOrderOption = _orderOptions.keys.toList()[0];
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() => AppState().assignmentUp = false);
    });
  }

  List jsonToAssignmentList(ApiCallResponse snapshot) =>
      GetScoresByUserCall.assignments(
        snapshot.jsonBody,
      ).toList();

  List<dynamic> filterAssignmentList(List<dynamic> list, String filter) {
    if (filter == _filterOptions[0]) return list;
    List outputList = list
        .where((o) => functions.equalsIgnoreCase(o['assignment_group'], filter))
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _mainController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CollapsingLibreAppBar(
              title: getJsonField(
                widget.course,
                r'''$.course_section_name''',
              ).toString(),
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
                      color: FlutterFlowTheme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).primaryColor,
                        width: 0,
                      ),
                    ),
                    child: DefaultTabController(
                      length: 2,
                      initialIndex: 0,
                      child: Column(
                        children: [
                          TabBar(
                            labelColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                            unselectedLabelColor: const Color(0xCBFFFFFF),
                            labelStyle: FlutterFlowTheme.of(context).bodyText1,
                            indicatorColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                            tabs: const [
                              Tab(
                                text: 'HOME',
                              ),
                              Tab(
                                text: 'ASSIGNMENTS',
                              ),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        color: FlutterFlowTheme.of(context)
                                            .coursePagePullDown,
                                        child: ExpandableNotifier(
                                          initialExpanded: false,
                                          child: ExpandablePanel(
                                            header: Container(
                                              alignment: Alignment.centerLeft,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 116,
                                              decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .coursePagePullDown),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                        Constants.mmMargin,
                                                        Constants.msMargin,
                                                        0,
                                                        Constants.msMargin),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              0,
                                                              0,
                                                              0,
                                                              Constants
                                                                  .msMargin),
                                                      child: RichText(
                                                        text: TextSpan(
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1
                                                                .override(
                                                                    fontFamily:
                                                                        'Open Sans',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .tertiaryText),
                                                            children: [
                                                              const TextSpan(
                                                                  text:
                                                                      'Instructor: '),
                                                              TextSpan(
                                                                text:
                                                                    getJsonField(
                                                                  widget.course,
                                                                  r'''$.instructor''',
                                                                ).toString(),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1
                                                                    .override(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
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
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Open Sans',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiaryText,
                                                                ),
                                                        children: <TextSpan>[
                                                          const TextSpan(
                                                            text:
                                                                'Start Date: ',
                                                          ),
                                                          TextSpan(
                                                            text: getJsonField(
                                                              widget.course,
                                                              r'''$.start_date''',
                                                            ).toString(),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Open Sans',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
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
                                                    FlutterFlowTheme.of(context)
                                                        .coursePagePullDown),
                                            expanded: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .coursePagePullDown,
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
                                                            Constants.mmMargin,
                                                            0,
                                                            0,
                                                            Constants.msMargin),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Open Sans',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiaryText,
                                                                ),
                                                        children: <TextSpan>[
                                                          const TextSpan(
                                                            text: 'End Date: ',
                                                          ),
                                                          TextSpan(
                                                            text: getJsonField(
                                                              widget.course,
                                                              r'''$.end_date''',
                                                            ).toString(),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Open Sans',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiaryText,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            Constants.mmMargin,
                                                            0,
                                                            0,
                                                            Constants.msMargin),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Open Sans',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiaryText,
                                                                ),
                                                        children: <TextSpan>[
                                                          const TextSpan(
                                                            text:
                                                                'Description: ',
                                                          ),
                                                          TextSpan(
                                                            text: getJsonField(
                                                              widget.course,
                                                              r'''$.public_description''',
                                                            ).toString(),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Open Sans',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiaryText,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            theme: ExpandableThemeData(
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
                                              iconSize: Constants.llMargin,
                                              iconPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 20, 0),
                                              iconColor:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiaryText,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(32, 24, 24, 24),
                                          child: Text(
                                            'Learning Process',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Open Sans',
                                                  fontWeight: FontWeight.bold,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tertiaryText,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: ScrollShadow(
                                            controller: _learningTabController,
                                            child: ListView.builder(
                                              controller:
                                                  _learningTabController,
                                              itemCount: 10,
                                              itemBuilder: (context, index) {
                                                return const AssignmentStatCtnWidget();
                                              },
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .coursePagePullDown,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            AssignmentDropdown(
                                              dropDownValue:
                                                  _currentFilterOption,
                                              itemList: _filterOptions,
                                              onItemSelectedCallback:
                                                  onFilterOptionSelected,
                                            ),
                                            AssignmentDropdown(
                                              dropDownValue:
                                                  _currentOrderOption,
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
                                            controller:
                                                _assignmentsTabController,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                FutureBuilder<ApiCallResponse>(
                                                  future:
                                                      GetScoresByUserCall.call(
                                                    token: StoredPreferences
                                                        .authToken,
                                                    course: widget.courseNumber,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 50,
                                                          height: 50,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    return Builder(
                                                      builder: (context) {
                                                        final filteredAssignmentList =
                                                            orderAssignmentList(
                                                                filterAssignmentList(
                                                                    jsonToAssignmentList(
                                                                        snapshot
                                                                            .data!),
                                                                    _currentFilterOption!),
                                                                _currentOrderOption!);
                                                        return ListView.builder(
                                                          padding:
                                                              EdgeInsets.zero,
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

                                                            return AssignmentCtn(
                                                                assignmentsItem:
                                                                    (assignmentsItem));
                                                          },
                                                        );
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
      ),
    );
  }
}
