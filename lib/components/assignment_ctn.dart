import 'package:adapt_clicker/components/connection_state_mixin.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../components/assignment_details_widget.dart';
import '../utils/constants.dart';

class AssignmentCtn extends ConsumerStatefulWidget {
  const AssignmentCtn({Key? key, required this.assignmentsItem})
      : super(key: key);
  final dynamic assignmentsItem;

  @override
  AssignmentCtnState createState() => AssignmentCtnState();
}



// Define a function that takes a date string and returns a formatted string
String formatDate(String date) {
  // Parse the date string using the given format
  DateTime parsedDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(date);
  // Format the date using the desired format
  String formattedDate = DateFormat('MM/dd/yy HH:mm a').format(parsedDate);
  // Return the formatted date
  return formattedDate;
}





class AssignmentCtnState extends ConsumerState<AssignmentCtn>
    with ConnectionStateMixin {

  late String submittedCount;
  late Color submittedColor;


  String formatSubmitted(List<String> parts) {
    // Split the input by the '/' character

    // Check if the input has exactly two parts
    if (parts.length == 2) {
      // Return the formatted string
      return '${parts[0]} out of ${parts[1]}';
    } else {
      // Return an error message
      return 'No records';
    }
  }

  Color getColor(List<String> parts) {
    var theme = FlutterFlowTheme.of(context);
    // Check if the input has exactly two parts
    if (parts.length == 2) {
      // Parse the parts as integers
      int n = int.parse(parts[0]);
      int m = int.parse(parts[1]);
      // Check if the denominator is not zero
      if (m != 0) {
        // Calculate the percentage completed
        double percentage = n / m;
        // Return a color based on the percentage
        // You can change the colors and thresholds as you like
        if (percentage >= 0.8) {
          return theme.activityGood;
        } else if (percentage >= 0.25) {
          return theme.activityMedium;
        } else {
          return theme.activityBad;
        }
      } else {
        // Return an error color
        return Colors.grey;
      }
    } else {
      // Return an error color
      return Colors.grey;
    }
  }


  Future<void> submitted() async {
    String temp = widget.assignmentsItem['number_submitted'];
    List<String> parts = temp.split('/');
    submittedCount = formatSubmitted(parts);
    submittedColor = getColor(parts);
  }

  @override
  Widget build(BuildContext context) {
    var theme =  FlutterFlowTheme.of(context);
    return Material(
      color: Colors.transparent,
      child: FutureBuilder(
        future: submitted(),
        builder: (context, snapshot) {
          return InkWell(
            onTap: () async {
              if (!checkConnection()) return;
              if (!AppState().assignmentUp && context.mounted) {
                setState(() => AppState().assignmentUp = true);
                await showModalBottomSheet(
                  useSafeArea: true,
                  isScrollControlled: true,
                  backgroundColor: theme.primaryBackground,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: SizedBox(
                        height: double.infinity,
                        child: AssignmentDetailsWidget(
                            assignmentSum: widget.assignmentsItem),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, Constants.xsMargin),
                                child: AutoSizeText(
                                  getJsonField(
                                    widget.assignmentsItem,
                                    r'''$.name''',
                                  ).toString().maybeHandleOverflow(
                                        maxChars: 14,
                                        replacement: '…',
                                      ),
                                  style: theme
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: theme
                                            .primaryColor,
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
                                style: theme
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Open Sans',
                                      color: theme.primaryColor,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, Constants.sMargin),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, Constants.xsMargin, 0),
                                    child: Icon(
                                      Icons.today_rounded,
                                      color: theme.tertiaryText,
                                      size: 20,
                                    ),
                                  ),
                                  Text(formatDate(widget.assignmentsItem['due']['due_date']),
                                    textAlign: TextAlign.start,
                                    style: theme.bodyText1.override(
                                      fontFamily: 'Open Sans',
                                      color: theme.tertiaryText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, Constants.xsMargin, 0),
                                  child: Icon(
                                    Icons.check_circle_outline,
                                    color: submittedColor,
                                    size: 20,
                                  ),
                                ),
                                Text(submittedCount,
                                  textAlign: TextAlign.start,
                                  style: theme.bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    color: submittedColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
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
          );
        }
      ),
    );
  }


}
