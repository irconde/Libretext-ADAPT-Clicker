import 'package:flutter_svg/svg.dart';

import '../flutter_flow/flutter_flow_util.dart';
import '../gen/assets.gen.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationSingle extends StatefulWidget {
  const NotificationSingle({
    Key? key, this.enrollmentsListItem}) : super(key: key);
  final dynamic enrollmentsListItem;

  @override
  _NotificationSingleWidgetState createState() =>
      _NotificationSingleWidgetState(enrollmentsListItem);
}

class _NotificationSingleWidgetState extends State<NotificationSingle> {
  _NotificationSingleWidgetState(this.enrollmentsListItem);
  dynamic enrollmentsListItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsetsDirectional.fromSTEB(30, 24, 0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                child: SvgPicture.asset('assets/images/book_icon.svg',
                  height: 24,
                  width: 24,),
              ),
              Text(
                getJsonField(
                  enrollmentsListItem,
                  r'''$.course_section_name''',
                ).toString(),
                style: FlutterFlowTheme.of(context)
                    .bodyText1
                    .override(
                  fontFamily: 'Open Sans',
                  color: FlutterFlowTheme.of(context)
                      .primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                30, 8, 0, 24),
            child: Text(
              getJsonField(
                enrollmentsListItem,
                r'''$.instructor''',
              ).toString(),
              style: FlutterFlowTheme.of(context)
                  .bodyText1
                  .override(
                fontFamily: 'Open Sans',
                color: FlutterFlowTheme.of(context)
                    .secondaryText,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            endIndent: 30,
          ),
        ],
      ),
    );

  }
}
