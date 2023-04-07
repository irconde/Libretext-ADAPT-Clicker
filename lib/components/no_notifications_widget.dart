import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class NoNotificationsWidget extends StatefulWidget {
  const NoNotificationsWidget({Key? key}) : super(key: key);

  @override
  State<NoNotificationsWidget> createState() => _NoNotificationsWidgetState();
}

class _NoNotificationsWidgetState extends State<NoNotificationsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 64),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Image.asset(
              'assets/images/no_notifications.png',
              width: double.infinity,
              height: 300,
              fit: BoxFit.none,
            ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'NO NOTIFICATIONS',
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Open Sans',
                      color: FlutterFlowTheme.of(context).primaryColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'FOR NOW',
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Open Sans',
                      color: FlutterFlowTheme.of(context).primaryColor,
                      fontSize: 28,
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
