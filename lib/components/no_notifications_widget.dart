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
      padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(48, 48, 48, 0),
            child: Image.asset(
              'assets/images/no_notifications.png',
              width: double.infinity,
              height: 300,
              fit: BoxFit.none,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'NO NOTIFACTIONS',
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
