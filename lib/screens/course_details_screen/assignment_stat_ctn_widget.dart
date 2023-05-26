import '../../constants/dimens.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../main.dart';
import '../../utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/utils.dart';

class AssignmentStatCtnWidget extends StatefulWidget {
  const AssignmentStatCtnWidget({Key? key, this.assignment}) : super(key: key);

  final dynamic assignment;
  @override
  State<AssignmentStatCtnWidget> createState() =>
      _AssignmentStatCtnWidgetState();
}

Color severityColor(BuildContext context, double percentage) {
  if (percentage < 50) {
    return CColors.activityBad;
  } else if (percentage < 80) {
    return CColors.activityMedium;
  } else {
    return CColors.activityGood;
  }
}

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
