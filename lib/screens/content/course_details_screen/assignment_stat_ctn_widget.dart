import 'package:adapt_clicker/constants/icons.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_theme.dart';
import '../../../constants/colors.dart';
import '../../../constants/dimens.dart';
import '../../../constants/strings.dart';
import '../../../utils/logger.dart';
import '../../../utils/utils.dart';

/// A widget for displaying assignment statistics.
/// The [assignment] parameter represents the data for the assignment.
class AssignmentStatCtnWidget extends StatefulWidget {
    const AssignmentStatCtnWidget({Key? key, this.assignment}) : super(key: key);

  /// The data for the assignment.
  final dynamic assignment;

  @override
  State<AssignmentStatCtnWidget> createState() =>
      _AssignmentStatCtnWidgetState();
}


class _AssignmentStatCtnWidgetState extends State<AssignmentStatCtnWidget> {

  //Local
  double _severity = 15.0;

  @override
  void initState() {
    calculateSeverity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = AppTheme.of(context);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(Dimens.mmMargin, 0, Dimens.mmMargin, 8),
      child: Container(
        width: double.infinity,
        height: Dimens.statContainerHeight,
        decoration: const BoxDecoration(
          color: CColors.assignmentBackground,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, Dimens.sMargin, 0),
              child: Container(
                width: Dimens.statContainerLeftBarWidth,
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, Dimens.xsMargin),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, Dimens.xsMargin, 0),
                          child: IIcons.statIcon,
                        ),
                        Text(
                          widget.assignment['name'] ??
                              Strings.activityDescription,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: theme.bodyText1.override(
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w600,
                            color: CColors.primaryColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: RichText(
                      text: TextSpan(
                        style: theme.bodyText1.override(
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
                style: theme.title2.override(
                      fontFamily: 'Open Sans',
                      color: severityColor(context, _severity),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  /// Calculates the severity based on the assignment's score and total points.
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


  /// Returns the color based on the severity percentage.
  /// The [context] parameter is required for accessing the current theme.
  /// The [percentage] parameter represents the severity percentage.
  /// Returns a color based on the severity:
  Color severityColor(BuildContext context, double percentage) {
    if (percentage < Dimens.badPercentage) {
      return CColors.activityBad;
    } else if (percentage < Dimens.mediumPercentage) {
      return CColors.activityMedium;
    } else {
      return CColors.activityGood;
    }
  }

  /// Formats a date string into a specific format.
  /// The [date] parameter is a date string in the format 'yyyy-MM-dd HH:mm:ss'.
  String formatDate(String date) {
    // Parse the date string using the given format
    DateTime parsedDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(date);
    // Format the date using the desired format
    String formattedDate = DateFormat("MM/dd/yy 'at' H:mm a").format(parsedDate);
    if (formattedDate.isNotEmpty) return formattedDate;
    return Strings.datePlaceholder;
  }

}
