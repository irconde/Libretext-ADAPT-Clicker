import '../../constants/dimens.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../main.dart';
import '../../utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/utils.dart';

class AssignmentStatCtnWidget extends StatefulWidget {
  /// A widget for displaying assignment statistics.
  ///
  /// The [assignment] parameter represents the data for the assignment.
  const AssignmentStatCtnWidget({Key? key, this.assignment}) : super(key: key);

  /// The data for the assignment.
  final dynamic assignment;

  @override
  State<AssignmentStatCtnWidget> createState() =>
      _AssignmentStatCtnWidgetState();
}

/// Returns the color based on the severity percentage.
///
/// The [context] parameter is required for accessing the current theme.
/// The [percentage] parameter represents the severity percentage.
/// Returns a color based on the severity:
/// - If the percentage is less than 50, returns [CColors.activityBad].
/// - If the percentage is less than 80, returns [CColors.activityMedium].
/// - Otherwise, returns [CColors.activityGood].
Color severityColor(BuildContext context, double percentage) {
  if (percentage < 50) {
    return CColors.activityBad;
  } else if (percentage < 80) {
    return CColors.activityMedium;
  } else {
    return CColors.activityGood;
  }
}

/// Formats a date string into a specific format.
///
/// The [date] parameter is a date string in the format 'yyyy-MM-dd HH:mm:ss'.
/// Returns a formatted string in the format 'MM/dd/yy 'at' H:mm a'.
/// If the formatting fails, returns [Strings.datePlaceholder].
String formatDate(String date) {
  // Parse the date string using the given format
  DateTime parsedDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(date);
  // Format the date using the desired format
  String formattedDate = DateFormat("MM/dd/yy 'at' H:mm a").format(parsedDate);
  if (formattedDate != null) {
    // Return the formatted date
    return formattedDate;
  }
  return Strings.datePlaceholder;
}

class _AssignmentStatCtnWidgetState extends State<AssignmentStatCtnWidget> {
  double _severity = 15.0;

  @override
  void initState() {
    calculateSeverity();
    super.initState();
  }

  /// Calculates the severity based on the assignment's score and total points.
  ///
  /// Updates the [_severity] value based on the assignment's score and total points.
  /// If the total points is 0, sets the [_severity] to 0.
  /// If the score is 'Not yet released', sets the score to 0 before calculating the [_severity].
  void calculateSeverity() {
    var score = widget.assignment['score'];
    var total = widget.assignment['total_points'];
    if (total == 0) {
      _severity = 0;
      return;
    }
    logger.d(widget.assignment['name']);
    logger.d('Score: $score');
    logger.d('Total: $total');
    if (score == 'Not yet released') {
      score = 0;
    }
    _severity = (score / total) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
          Dimens.mmMargin, 0, Dimens.mmMargin, 8),
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: const BoxDecoration(
          color: CColors.assignmentBackground,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(0, 0, Dimens.sMargin, 0),
              child: Container(
                width: 4,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: severityColor(context, _severity),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0, 0, 0, Dimens.xsMargin),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0, 0, Dimens.xsMargin, 0),
                          child: FaIcon(
                            FontAwesomeIcons.brain,
                            color: CColors.primaryColor,
                            size: 16,
                          ),
                        ),
                        SizedBox(
                          width: 140,
                          child: Text(
                            widget.assignment['name'] ??
                                Strings.activityDescription,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: AppTheme.of(context).bodyText1.override(
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w600,
                                  color: CColors.primaryColor,
                                  fontSize: 16,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: RichText(
                      text: TextSpan(
                        style: AppTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.normal,
                              color: CColors.tertiaryText,
                            ),
                        children: [
                          TextSpan(
                            text: formatDate(
                                widget.assignment['due']['due_date']),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(0, 0, Dimens.sMargin, 0),
              child: Text(
                '$_severity%',
                style: AppTheme.of(context).bodyText1.override(
                      fontFamily: 'Open Sans',
                      color: severityColor(context, _severity),
                      fontSize: Dimens.msMargin,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
