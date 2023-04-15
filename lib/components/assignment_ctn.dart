import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../components/assignment_details_widget.dart';
import '../gen/assets.gen.dart';
import '../utils/check_internet_connectivity.dart';
import '../flutter_flow/custom_functions.dart' as functions;

class AssignmentCtn extends ConsumerStatefulWidget {
  const AssignmentCtn({Key? key, required this.assignmentsItem})
      : super(key: key);
  final dynamic assignmentsItem;

  @override
  AssignmentCtnState createState() => AssignmentCtnState();
}

class AssignmentCtnState extends ConsumerState<AssignmentCtn> {

  bool _checkConnection() {
    ConnectivityStatus? status =
        ref.read(provider.notifier).getConnectionStatus();
    if (status != ConnectivityStatus.isConnected) {
      functions.showSnackbar(context, status);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          onTap: () async {
            if (!_checkConnection()) return;

            if (!AppState().assignmentUp && context.mounted) {
              setState(() => AppState().assignmentUp = true);
              await showModalBottomSheet(
                useSafeArea: true,
                isScrollControlled: true,
                backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                context: context,
                builder: (context) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: SizedBox(
                      height: double.infinity,
                      child: AssignmentDetailsWidget(
                        assignmentItem: widget.assignmentsItem
                      ),
                    ),
                  );
                },
              );
            }
            setState(() => AppState().assignmentUp = false);

            setState(() {});
          },

          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
                Constants.mmMargin, 0, Constants.mmMargin, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
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
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                              child: AutoSizeText(
                                getJsonField(
                                  widget.assignmentsItem,
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
                                widget.assignmentsItem,
                                r'''$.assignment_group''',
                              ).toString().maybeHandleOverflow(maxChars: 20),
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color:
                                        FlutterFlowTheme.of(context).tertiaryText,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                        child: Icon(
                          Icons.today_rounded,
                          color: FlutterFlowTheme.of(context).tertiaryText,
                          size: 20,
                        ),
                      ),
                      Text(
                        getJsonField(
                          widget.assignmentsItem,
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
                const Divider(
                  height: 1,
                  thickness: 1,
                ),
              ],
            ),
          ),
      ),
    );
  }
}
