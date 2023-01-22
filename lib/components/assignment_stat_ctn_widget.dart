import '../gen/assets.gen.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AssignmentStatCtnWidget extends StatefulWidget {
  const AssignmentStatCtnWidget({Key? key}) : super(key: key);

  @override
  _AssignmentStatCtnWidgetState createState() =>
      _AssignmentStatCtnWidgetState();
}

Color severityColor(BuildContext context, double percentage) {
  if (percentage < 50)
    return FlutterFlowTheme.of(context).activityBad;
  else if (percentage < 80)
    return FlutterFlowTheme.of(context).activityMedium;
  else
    return FlutterFlowTheme.of(context).activityGood;
}

class _AssignmentStatCtnWidgetState extends State<AssignmentStatCtnWidget> {
  double severityVariable = 15.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          Constants.mmMargin, 0, Constants.mmMargin, 8),
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          color: Color(0xFFDCF1FF),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
                  EdgeInsetsDirectional.fromSTEB(0, 0, Constants.sMargin, 0),
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
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0, 0, 0, Constants.xsMargin),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0, 0, Constants.xsMargin, 0),
                            child: FaIcon(
                              FontAwesomeIcons.brain,
                              color: FlutterFlowTheme.of(context).primaryColor,
                              size: 16,
                            ),
                          ),
                          Text(
                            'Activity Description',
                            style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w600,
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  fontSize: 16,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child: RichText(
                        text: TextSpan(
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.normal,
                                color:
                                    FlutterFlowTheme.of(context).tertiaryText,
                              ),
                          children: [
                            TextSpan(
                              text: 'Due Date: ',
                            ),
                            TextSpan(
                              text: '8/18/2022 at 1:43 pm',
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
                  EdgeInsetsDirectional.fromSTEB(0, 0, Constants.sMargin, 0),
              child: Text(
                severityVariable.toString() + '%',
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Open Sans',
                      color: severityColor(context, severityVariable),
                      fontSize: Constants.msMargin,
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
