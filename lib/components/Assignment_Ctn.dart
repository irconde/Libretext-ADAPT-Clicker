import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../components/assignment_details_widget.dart';
import '../backend/api_requests/api_calls.dart';
import '../gen/assets.gen.dart';

class AssignmentCtn extends StatefulWidget {
  const AssignmentCtn({Key? key, required this.assignmentsItem})
      : super(key: key);
  final assignmentsItem;

  @override
  State<StatefulWidget> createState() => AssignmentCtnState(assignmentsItem);
}

class AssignmentCtnState extends State<AssignmentCtn> {
  AssignmentCtnState(this.assignmentsItem);

  ApiCallResponse? assignmentSummary;
  ApiCallResponse? assignmentSum;
  dynamic assignmentsItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          Constants.mmMargin, 0, Constants.mmMargin, 0),
      child: InkWell(
        onTap: () async {
          assignmentSummary = await GetAssignmentSummaryCall.call(
            token: FFAppState().authToken,
            assignmentNum: getJsonField(
              assignmentsItem,
              r'''$.id''',
            ),
          );
          if (!FFAppState().assignmentUp) {
            setState(() => FFAppState().assignmentUp = true);
            await showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              context: context,
              builder: (context) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Container(
                    height: double.infinity,
                    child: AssignmentDetailsWidget(
                      assignmentSum: GetAssignmentSummaryCall.assignment(
                        (assignmentSummary?.jsonBody ?? ''),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          setState(() => FFAppState().assignmentUp = false);

          setState(() {});
        },
        onDoubleTap: () async {
          assignmentSum = await GetAssignmentSummaryCall.call(
            token: FFAppState().authToken,
            assignmentNum: getJsonField(
              assignmentsItem,
              r'''$.id''',
            ),
          );
          if (!FFAppState().assignmentUp) {
            setState(() => FFAppState().assignmentUp = true);
            await showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              context: context,
              builder: (context) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Container(
                    height: double.infinity,
                    child: AssignmentDetailsWidget(
                      assignmentSum: GetAssignmentSummaryCall.assignment(
                        (assignmentSum?.jsonBody ?? ''),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          setState(() => FFAppState().assignmentUp = false);

          setState(() {});
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  0, Constants.msMargin, 0, Constants.msMargin),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0, 0, 0, 8),
                          child: AutoSizeText(
                            getJsonField(
                              assignmentsItem,
                              r'''$.name''',
                            ).toString().maybeHandleOverflow(
                                  maxChars: 14,
                                  replacement: '…',
                                ),
                            style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Open Sans',
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
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
                                color: FlutterFlowTheme.of(context).tertiaryText,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                      child: Icon(
                        Icons.today_rounded,
                        color: FlutterFlowTheme.of(context).tertiaryText,
                        size: 20,
                      ),
                    ),
                  Text(
                    getJsonField(
                      assignmentsItem,
                      r'''$..due_date''',
                    ).toString(),
                    textAlign: TextAlign.end,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: FlutterFlowTheme.of(context).tertiaryText,
                        ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
