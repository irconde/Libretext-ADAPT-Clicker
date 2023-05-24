import '../../constants/dimens.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AssignmentStatCtnWidget extends StatefulWidget {
  const AssignmentStatCtnWidget({Key? key}) : super(key: key);

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

class _AssignmentStatCtnWidgetState extends State<AssignmentStatCtnWidget> {
  double severityVariable = 15.0;

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
                  color: severityColor(context, severityVariable),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
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
                          Text(
                            Strings.activityDescription,
                            style: AppTheme.of(context).bodyText1.override(
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
                          style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.normal,
                                color: CColors.tertiaryText,
                              ),
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const TextSpan(
                              text: Strings.dueDate,
                            ),
                            const TextSpan(
                              text: Strings.datePlaceholder,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(0, 0, Dimens.sMargin, 0),
              child: Text(
                '$severityVariable%',
                style: AppTheme.of(context).bodyText1.override(
                      fontFamily: 'Open Sans',
                      color: severityColor(context, severityVariable),
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
