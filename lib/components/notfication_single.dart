import 'package:flutter_svg/svg.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class NotificationSingle extends StatefulWidget {
  const NotificationSingle({
    Key? key, this.enrollmentsListItem}) : super(key: key);
  final dynamic enrollmentsListItem;

  @override
  _NotificationSingleWidgetState createState() =>
      _NotificationSingleWidgetState();
}

class _NotificationSingleWidgetState extends State<NotificationSingle> {
  _NotificationSingleWidgetState();
  bool dismissed = false;

  @override
  Widget build(BuildContext context) {
    if (dismissed) {
      return SizedBox.shrink();
    }
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
        child: Align(
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Icon(Icons.delete),
          ),
          alignment: Alignment.centerLeft,
        ),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        child: Align(
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(Icons.delete),
          ),
          alignment: Alignment.centerRight,
        ),
      ),
       onDismissed: (_) {
        setState(() {
          dismissed = true;
          FFAppState().removeNotification(widget.enrollmentsListItem.toString());
         });
       },
      child: Padding(
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
                    widget.enrollmentsListItem,
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
                  widget.enrollmentsListItem,
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
      ),
    );

  }
}
