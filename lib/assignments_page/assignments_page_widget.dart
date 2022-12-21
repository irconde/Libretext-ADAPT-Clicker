import 'package:adapt_clicker/components/AssignmentDropdown.dart';
import '../backend/api_requests/api_calls.dart';
import '../components/Assignment_Ctn.dart';
import '../components/assignment_stat_ctn_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../gen/assets.gen.dart';


class AssignmentsPageWidget extends StatefulWidget {
  const AssignmentsPageWidget({
    Key? key,
    this.courseNumber,
    this.course,
  }) : super(key: key);

  final int? courseNumber;
  final dynamic course;

  @override
  _AssignmentsPageWidgetState createState() => _AssignmentsPageWidgetState();
}

class _AssignmentsPageWidgetState extends State<AssignmentsPageWidget> {
  String? dropDownValue;
  String? dropDownValue2;
  List<String> dropDownList1 = ['All Assignment Groups', 'Exam', 'Extra Credit', 'Homework', 'Lab'];
  List<String> dropDownList2 = ['Name', 'Start Date', 'Due Date'];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var top = 0.0;

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() => FFAppState().assignmentUp = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                backgroundColor: FlutterFlowTheme.of(context).primaryColor,
                expandedHeight: 160.0,
                pinned: true,
                snap: false,
                floating: false,
                flexibleSpace: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  top = constraints.biggest.height;
                  return FlexibleSpaceBar(
                    title: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: 1.0,
                        child: Text("Introduction to this",
                            style: FlutterFlowTheme.of(context).title2)),
                  );
                })),
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
                            unselectedLabelColor: Color(0xCBFFFFFF),
                            labelStyle: FlutterFlowTheme.of(context).bodyText1,
                            indicatorColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                            tabs: [
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
                                    mainAxisSize: MainAxisSize.max,
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
                                              height: 120,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFF3F3F3),
                                              ),
                                              child: Padding(
                                                  padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(Constants.mmMargin, Constants.msMargin, 0, Constants.msMargin),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                     Padding(
                                                       padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, Constants.msMargin),
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
                                                                      color: FlutterFlowTheme
                                                                              .of(context)
                                                                          .tertiaryText),
                                                              children: [
                                                                TextSpan(
                                                                    text:
                                                                        'Instructor: '),
                                                                TextSpan(
                                                                  text: getJsonField(
                                                                    widget.course,
                                                                    r'''$.instructor''',
                                                                  ).toString(),
                                                                  style: FlutterFlowTheme
                                                                          .of(context)
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
                                                            TextSpan(
                                                              text: 'Start Date: ',
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
                                            collapsed: Container(),
                                            expanded: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                color: FlutterFlowTheme.of(context).primaryColor,
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsetsDirectional.fromSTEB(Constants.mmMargin, 0, 0, Constants.msMargin),
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
                                                          TextSpan(
                                                            text: 'End Date: ',
                                                          ),
                                                          TextSpan(
                                                            text:  getJsonField(
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
                                                  ),Padding(
                                                    padding: const EdgeInsetsDirectional.fromSTEB(Constants.mmMargin, 0, 0, Constants.msMargin),
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
                                                          TextSpan(
                                                            text:  'Description: ',
                                                          ),
                                                          TextSpan(
                                                            text:  getJsonField(
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
                                              iconPadding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                              iconColor:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiaryText,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Material(
                                        elevation: 4,
                                        child: Container(
                                          width: double.infinity,
                                          height: 64,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                          alignment:
                                              AlignmentDirectional(-0.8, 0),
                                          child: Text(
                                            'Learning Process',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1,
                                          ),

                                        ),
                                      ),
                                      AssignmentStatCtnWidget(),
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
                                            color: Color(0xFFF3F3F3),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              AssignmentDropdown(dropDownValue: dropDownValue, dropDownList: dropDownList1),
                                              AssignmentDropdown(dropDownValue: dropDownValue2, dropDownList: dropDownList2),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                FutureBuilder<ApiCallResponse>(
                                                  future:
                                                      GetScoresByUserCall.call(
                                                    token:
                                                        FFAppState().authToken,
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
                                                    final listViewGetScoresByUserResponse =
                                                        snapshot.data!;
                                                    return Builder(
                                                      builder: (context) {
                                                        final assignments =
                                                            GetScoresByUserCall
                                                                .assignments(
                                                          listViewGetScoresByUserResponse
                                                              .jsonBody,
                                                        ).toList();
                                                        return ListView.builder(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          shrinkWrap: true,
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemCount: assignments
                                                              .length,
                                                          itemBuilder: (context,
                                                              assignmentsIndex) {
                                                            final assignmentsItem =
                                                                assignments[
                                                                    assignmentsIndex];

                                                            return AssignmentCtn(assignmentsItem: (assignmentsItem));
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
