import 'package:adapt_clicker/app_state.dart';
import 'package:adapt_clicker/components/no_notifications_widget.dart';
import 'package:adapt_clicker/components/notification_single.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/gestures.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart';

@RoutePage()
class NotificationsPageWidget extends StatefulWidget {
  const NotificationsPageWidget({Key? key}) : super(key: key);

  @override
  State<NotificationsPageWidget> createState() =>
      _NotificationsPageWidgetState();
}

void createList() {
  if (FFAppState().notificationList.isEmpty) return;
}

void addNotification(String details) {
  FFAppState().addNotification(details);
}

class _NotificationsPageWidgetState extends State<NotificationsPageWidget> {
  @override
  void initState() {
    super.initState();
    //createList();
    //addNotification('details');
  }

  void clearNotifications() {
    setState(() {
      FFAppState().clearNotifications();
    });
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: FlutterFlowTheme.of(context).primaryBackground,
              size: 24,
            ),
          onPressed: () async {
            Navigator.pop(context, '/');
          },
          ),
        title: const Text('Notifications'),
        actions: [
          Align(
            alignment: const AlignmentDirectional(0, 0),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, Constants.sMargin, 0),
              child: ClearAllWidget(isActive: FFAppState().notificationList.isNotEmpty, onTap: clearNotifications),
            ),
          ),
        ],
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child:  FFAppState().notificationList.isEmpty ? const Align(alignment: Alignment.bottomCenter, child: NoNotificationsWidget()) : ListView.builder(
                    itemCount: FFAppState().notificationList.length,

                    itemBuilder: (BuildContext context, int index) {


                      return Dismissible(
                        key: UniqueKey(),
                        background: Container(
                          color: Colors.red,
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        secondaryBackground: Container(
                          color: Colors.red,
                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Icon(Icons.delete),
                            ),
                          ),
                        ),
                        onDismissed: (_) {
                          setState(() {
                            FFAppState().removeNotification(index);
                          });
                        },
                        child: NotificationSingle(
                          index: index,
                        ),
                      );
                    }
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool notificationEmpty()
  {
    return true;
  }
}

// Clear All
class ClearAllWidget extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;
  const ClearAllWidget({Key? key, required this.isActive, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? FlutterFlowTheme.of(context).primaryBackground
        : FlutterFlowTheme.of(context).clearAllColor;

    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: 'Clear All ',
            recognizer: TapGestureRecognizer()
              ..onTap = () {

                if(isActive) {
                  onTap();
                }
              },
            style: FlutterFlowTheme.of(context).bodyText1.override(
              fontFamily: 'Open Sans',
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}



