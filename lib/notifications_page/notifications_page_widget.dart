import 'package:adapt_clicker/app_state.dart';
import 'package:adapt_clicker/components/notification_single.dart';
import 'package:flutter/gestures.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import '../gen/assets.gen.dart';

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
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(Constants.sMargin, 0, 0, 0),
          child: InkWell(
            onTap: () async {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: FlutterFlowTheme.of(context).primaryBackground,
              size: 32,
            ),
          ),
        ),
        title: Align(
          alignment: const AlignmentDirectional(0, 0),
          child: Text(
            'Notifications',
            style: FlutterFlowTheme.of(context).bodyText1.override(
                  fontFamily: 'Open Sans',
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        actions: [
          Align(
            alignment: const AlignmentDirectional(0, 0),
            child: Padding(
              padding:
                  EdgeInsetsDirectional.fromSTEB(0, 0, Constants.sMargin, 0),
              child: RichText(
                  text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: 'Clear All ',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          debugPrint('The button is clicked!');
                          setState(() {
                            FFAppState().clearNotifications();
                          });
                        },
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Open Sans',
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          )),
                ],
              )),
            ),
          ),
        ],
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: ListView.builder(
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
                              child: Icon(Icons.delete, color: Colors.white,),
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
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
