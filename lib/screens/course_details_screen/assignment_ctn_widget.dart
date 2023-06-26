import 'package:adapt_clicker/mixins/connection_state_mixin.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/strings.dart';
import '../../utils/app_theme.dart';
import '../../utils/utils.dart';
import '../assignment_screen/assignment_screen.dart';
import '../../constants/dimens.dart';
import '../../constants/colors.dart';

class AssignmentCtnWidget extends ConsumerStatefulWidget {
  /// A widget for displaying assignment information.
  ///
  /// The [assignmentsItem] parameter is required and represents the data
  /// for the assignment.
  const AssignmentCtnWidget({Key? key, required this.assignmentsItem})
      : super(key: key);

  /// The data for the assignment.
  final dynamic assignmentsItem;

  @override
  AssignmentCtnWidgetState createState() => AssignmentCtnWidgetState();
}

/// A function that formats a date string into a specific format.
///
/// It takes a [date] string in the format 'yyyy-MM-dd HH:mm:ss'
/// and returns a formatted string in the format 'MM/dd/yy HH:mm a'.
String formatDate(String date) {
  // Parse the date string using the given format
  DateTime parsedDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(date);
  // Format the date using the desired format
  String formattedDate = DateFormat('MM/dd/yy HH:mm a').format(parsedDate);
  // Return the formatted date
  return formattedDate;
}

String semanticDate(String date) {
  if (date == 'N/A') {
    return '';
  }
  // Parse the date string using the given format
  DateTime parsedDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(date);
  // Format the date using the desired format
  String formattedDate = DateFormat("MMM d yy 'at' HH a").format(parsedDate);
  // Return the formatted date
  return formattedDate;
}

class AssignmentCtnWidgetState extends ConsumerState<AssignmentCtnWidget>
    with ConnectionStateMixin {
  late String submittedCount;
  late Color submittedColor;

  /// Formats the submitted count into a specific format.
  ///
  /// It takes a list of [parts], which should have exactly two elements.
  /// If the input is valid, it returns a formatted string in the format 'x out of y'.
  /// Otherwise, it returns an error message.
  String formatSubmitted(List<String> parts) {
    // Split the input by the '/' character
    // Check if the input has exactly two parts
    if (parts.length == 2) {
      // Return the formatted string
      return '${parts[0]} ${Strings.outOf} ${parts[1]}';
    } else {
      // Return an error message
      return Strings.noRecords;
    }
  }

  /// Determines the color based on the submitted count.
  ///
  /// It takes a list of [parts], which should have exactly two elements.
  /// If the input is valid, it calculates the completion percentage
  /// and returns a color based on the percentage. Otherwise, it returns
  /// a default error color.
  Color getColor(List<String> parts) {
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
          return CColors.activityGood;
        } else if (percentage >= 0.25) {
          return CColors.activityMedium;
        } else {
          return CColors.activityBad;
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

  /// Retrieves the submitted count and color asynchronously.
  ///
  /// It sets the [submittedCount] and [submittedColor] based on the
  /// [assignmentsItem] data.
  Future<void> submitted() async {
    String temp = widget.assignmentsItem['number_submitted'];
    List<String> parts = temp.split('/');
    submittedCount = formatSubmitted(parts);
    submittedColor = getColor(parts);
  }

  @override
  Widget build(BuildContext context) {
    var theme = AppTheme.of(context);
    return Material(
      color: Colors.transparent,
      child: FutureBuilder(
          future: submitted(),
          builder: (context, snapshot) {
            return InkWell(
              onTap: () async {
                //Checking Internet
                if (!checkConnection()) return;
                //Setting assignment ID
                setState(() =>
                    AppState().assignmentId = widget.assignmentsItem['id']);
                //Check if assignments already trying to load
                if (!AppState().assignmentUp && context.mounted) {
                  setState(() => AppState().assignmentUp = true);
                  await showModalBottomSheet(
                    useSafeArea: true,
                    isScrollControlled: true,
                    backgroundColor: CColors.primaryBackground,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: SizedBox(
                          height: double.infinity,
                          child: AssignmentScreen(
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
                    Dimens.mmMargin, 0, Dimens.mmMargin, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0, Dimens.msMargin, 0, Dimens.msMargin),
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
                                      0, 0, 0, Dimens.xsMargin),
                                  child: AutoSizeText(
                                    getJsonField(
                                      widget.assignmentsItem,
                                      r'''$.name''',
                                    ).toString().maybeHandleOverflow(
                                          maxChars: 14,
                                          replacement: '…',
                                        ),
                                    style: theme.bodyText1.override(
                                      fontFamily: 'Open Sans',
                                      color: CColors.primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  getJsonField(
                                    widget.assignmentsItem,
                                    r'''$.assignment_group''',
                                  )
                                      .toString()
                                      .maybeHandleOverflow(maxChars: 20),
                                  style: theme.bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    color: CColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, Dimens.sMargin),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, Dimens.xsMargin, 0),
                                      child: Icon(
                                        Icons.today_rounded,
                                        color: CColors.tertiaryText,
                                        size: 20,
                                      ),
                                    ),
                                    Semantics(
                                      label: semanticDate(widget
                                          .assignmentsItem['due']['due_date']),
                                      child: ExcludeSemantics(
                                        child: Text(
                                          formatDate(
                                              widget.assignmentsItem['due']
                                                  ['due_date']),
                                          textAlign: TextAlign.start,
                                          style: theme.bodyText1.override(
                                            fontFamily: 'Open Sans',
                                            color: CColors.tertiaryText,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, Dimens.xsMargin, 0),
                                    child: Icon(
                                      Icons.check_circle_outline,
                                      color: submittedColor,
                                      size: 20,
                                    ),
                                  ),
                                  Text(
                                    submittedCount,
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
          }),
    );
  }
}
