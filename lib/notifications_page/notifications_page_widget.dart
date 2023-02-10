import 'package:adapt_clicker/utils/stored_preferences.dart';
import 'package:auto_route/auto_route.dart';
import 'package:adapt_clicker/components/notfication_single.dart';
import 'package:flutter/gestures.dart';

import '../backend/api_requests/api_calls.dart';
import '../components/no_notifications_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationsPageWidget extends StatefulWidget {
  const NotificationsPageWidget({Key? key}) : super(key: key);

  @override
  State<NotificationsPageWidget> createState() =>
      _NotificationsPageWidgetState();
}

ApiCallResponse? _notificationsResponse;
List<NotificationSingle> notificationList = [];

void getEnrollments() async {
  List<dynamic> list = [];

  if (FFAppState().notificationSet) {
    dynamic temp;
    for (var item in FFAppState().notificationList) {
      list.add(getJsonField(temp, item));
    }
    createList(list);
    return;
  } else {
    //Dummy code, this is only until push notifications replace the api call. Then get enrollments will just be the if statement

    _notificationsResponse ??= await GetEnrollmentsCall.call(
      token: FFAppState().authToken,
    );

    list = getJsonField(_notificationsResponse?.jsonBody, r'''$.enrollments''');
    for (var item in list) {
      FFAppState().addNotification(item.toString());
      NotificationSingle temp =
          new NotificationSingle(enrollmentsListItem: item);
      notificationList.add(temp);
    }
    FFAppState().notificationSet = true;
  }
}

void createList(List<dynamic> list) {
  if (notificationList.isNotEmpty) notificationList.clear();

  for (var item in list) {
    NotificationSingle temp = new NotificationSingle(enrollmentsListItem: item);
    notificationList.add(temp);
  }
}

class _NotificationsPageWidgetState extends State<NotificationsPageWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEnrollments();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () async {
            context.popRoute();
          },
        ),
        title: const Text('Notifications'),
        actions: [
          Align(
            alignment: const AlignmentDirectional(0, 0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
              child: RichText(
                  text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: 'Clear All ',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          debugPrint('The button is clicked!');
                          setState(() {
                            notificationList.clear();
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
                    shrinkWrap: true,
                    itemCount: notificationList.length,
                    itemBuilder: (BuildContext context, int index) {
                      // access element from list using index
                      // you can create and return a widget of your choice
                      return notificationList[index];
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
