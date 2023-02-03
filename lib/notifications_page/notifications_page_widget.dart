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

class _NotificationsPageWidgetState extends State<NotificationsPageWidget> {
  ApiCallResponse? _apiRequestCompleter;

  List<NotificationSingle> notificationList = [];

  @override
  void initState() {
    super.initState();
    getEnrollments();
  }

  void getEnrollments() async {
    _apiRequestCompleter ??= await GetEnrollmentsCall.call(
      token: FFAppState().authToken,
    );

    final enrollmentsList =
        getJsonField(_apiRequestCompleter?.jsonBody, r'''$.enrollments''');
    if (enrollmentsList.isEmpty) {
      return;
    }

    for (var item in enrollmentsList) {
      NotificationSingle temp =
          new NotificationSingle(enrollmentsListItem: item);
      notificationList.add(temp);
    }
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
                          //enrollmentsList.clear();
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
              ListView.builder(
                  itemCount: notificationList.length,
                  itemBuilder: (BuildContext context, int index) {
                    // access element from list using index
                    // you can create and return a widget of your choice
                    return notificationList[index];
                  })
            ],
          ),
        ),
      ),
    );
  }
}
