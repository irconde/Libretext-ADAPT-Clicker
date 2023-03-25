import 'package:flutter_svg/svg.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class NotificationSingle extends StatefulWidget {
  const NotificationSingle({
    Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  _NotificationSingleWidgetState createState() =>
      _NotificationSingleWidgetState();
}


class _NotificationSingleWidgetState extends State<NotificationSingle> {
  _NotificationSingleWidgetState();
  bool dismissed = false;

  dynamic keyVal = UniqueKey();


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
                  "Notification ${widget.index}",
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
                "Details",
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
