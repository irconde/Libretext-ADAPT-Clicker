import '../backend/api_requests/api_calls.dart';
import '../components/assignment_details_widget.dart';
import '../components/assignment_stat_ctn_widget.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../notifications_page/notifications_page_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

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
  ApiCallResponse? assignmentSum;
  ApiCallResponse? assignmentSummary;
  String? dropDownValue1;
  String? dropDownValue2;
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

  String checkTop(var topSize) {
    if (topSize <= 120) {
      return "Introduction to this";
    } else {
      return "Introduction \n to this";
    }
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
                        child: Text(checkTop(top),
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
                                                      .fromSTEB(32, 24, 0, 24),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                     Padding(
                                                       padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
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
                                                color: Color(0xFFF3F3F3),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsetsDirectional.fromSTEB(32, 0, 0, 24),
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
                                                    padding: const EdgeInsetsDirectional.fromSTEB(32, 0, 0, 24),
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
                                              iconSize: 48,
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
                                      AssignmentStatCtnWidget(
                                        severityColor: Color(0xFF00FF58),
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
                                            color: Color(0xFFF3F3F3),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              FlutterFlowDropDown(
                                                initialOption:
                                                    dropDownValue1 ??=
                                                        'ALL ASSIGNMENTS',
                                                options: ['ALL ASSIGNMENTS'],
                                                onChanged: (val) => setState(
                                                    () => dropDownValue1 = val),
                                                width: 172,
                                                height: 40,
                                                textStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Open Sans',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      fontSize: 13,
                                                    ),
                                                hintText: 'ALL ASSIGNMENTS',
                                                fillColor: Color(0x00FFFFFF),
                                                elevation: 2,
                                                borderColor: Color(0x6F101213),
                                                borderWidth: 1,
                                                borderRadius: 0,
                                                margin: EdgeInsetsDirectional
                                                    .fromSTEB(12, 4, 12, 4),
                                                hidesUnderline: true,
                                              ),
                                              FlutterFlowDropDown(
                                                initialOption:
                                                    dropDownValue2 ??=
                                                        'ORDER: BY NAME',
                                                options: ['ORDER: BY NAME'],
                                                onChanged: (val) => setState(
                                                    () => dropDownValue2 = val),
                                                width: 172,
                                                height: 40,
                                                textStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Open Sans',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      fontSize: 13,
                                                    ),
                                                hintText: 'ORDER: BY NAME',
                                                fillColor: Color(0x00FFFFFF),
                                                elevation: 2,
                                                borderColor: Color(0x6F101213),
                                                borderWidth: 1,
                                                borderRadius: 0,
                                                margin: EdgeInsetsDirectional
                                                    .fromSTEB(12, 4, 12, 4),
                                                hidesUnderline: true,
                                              ),
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
                                                            return Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          24,
                                                                          0,
                                                                          24,
                                                                          0),
                                                              child: InkWell(
                                                                onTap:
                                                                    () async {
                                                                  assignmentSummary =
                                                                      await GetAssignmentSummaryCall
                                                                          .call(
                                                                    token: FFAppState()
                                                                        .authToken,
                                                                    assignmentNum:
                                                                        getJsonField(
                                                                      assignmentsItem,
                                                                      r'''$.id''',
                                                                    ),
                                                                  );
                                                                  if (!FFAppState()
                                                                      .assignmentUp) {
                                                                    setState(() =>
                                                                        FFAppState().assignmentUp =
                                                                            true);
                                                                    await showModalBottomSheet(
                                                                      isScrollControlled:
                                                                          true,
                                                                      backgroundColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .primaryBackground,
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return Padding(
                                                                          padding:
                                                                              MediaQuery.of(context).viewInsets,
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                double.infinity,
                                                                            child:
                                                                                AssignmentDetailsWidget(
                                                                              assignmentSum: GetAssignmentSummaryCall.assignment(
                                                                                (assignmentSummary?.jsonBody ?? ''),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    );
                                                                  }
                                                                  await Future.delayed(
                                                                      const Duration(
                                                                          milliseconds:
                                                                              1000));
                                                                  setState(() =>
                                                                      FFAppState()
                                                                              .assignmentUp =
                                                                          false);

                                                                  setState(
                                                                      () {});
                                                                },
                                                                onDoubleTap:
                                                                    () async {
                                                                  assignmentSum =
                                                                      await GetAssignmentSummaryCall
                                                                          .call(
                                                                    token: FFAppState()
                                                                        .authToken,
                                                                    assignmentNum:
                                                                        getJsonField(
                                                                      assignmentsItem,
                                                                      r'''$.id''',
                                                                    ),
                                                                  );
                                                                  if (!FFAppState()
                                                                      .assignmentUp) {
                                                                    setState(() =>
                                                                        FFAppState().assignmentUp =
                                                                            true);
                                                                    await showModalBottomSheet(
                                                                      isScrollControlled:
                                                                          true,
                                                                      backgroundColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .primaryBackground,
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return Padding(
                                                                          padding:
                                                                              MediaQuery.of(context).viewInsets,
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                double.infinity,
                                                                            child:
                                                                                AssignmentDetailsWidget(
                                                                              assignmentSum: GetAssignmentSummaryCall.assignment(
                                                                                (assignmentSum?.jsonBody ?? ''),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    );
                                                                  }
                                                                  await Future.delayed(
                                                                      const Duration(
                                                                          milliseconds:
                                                                              1000));
                                                                  setState(() =>
                                                                      FFAppState()
                                                                              .assignmentUp =
                                                                          false);

                                                                  setState(
                                                                      () {});
                                                                },
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              0,
                                                                              24,
                                                                              0,
                                                                              24),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                                                                                child: AutoSizeText(
                                                                                  getJsonField(
                                                                                    assignmentsItem,
                                                                                    r'''$.name''',
                                                                                  ).toString().maybeHandleOverflow(
                                                                                        maxChars: 16,
                                                                                        replacement: '…',
                                                                                      ),
                                                                                  style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                        fontFamily: 'Open Sans',
                                                                                        color: FlutterFlowTheme.of(context).primaryColor,
                                                                                        fontSize: 16,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                getJsonField(
                                                                                  assignmentsItem,
                                                                                  r'''$.assignment_group''',
                                                                                ).toString().maybeHandleOverflow(maxChars: 20),
                                                                                style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                      fontFamily: 'Open Sans',
                                                                                      fontWeight: FontWeight.normal,
                                                                                    ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              getJsonField(
                                                                                assignmentsItem,
                                                                                r'''$..due_date''',
                                                                              ).toString(),
                                                                              textAlign: TextAlign.end,
                                                                              style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                    fontFamily: 'Open Sans',
                                                                                    fontWeight: FontWeight.normal,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                17,
                                                                                0,
                                                                                0,
                                                                                0),
                                                                            child:
                                                                                Icon(
                                                                              Icons.today_sharp,
                                                                              color: FlutterFlowTheme.of(context).secondaryColor,
                                                                              size: 24,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Divider(
                                                                      height: 1,
                                                                      thickness:
                                                                          1,
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
