import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsPageWidget extends StatefulWidget {
  const NotificationsPageWidget({Key? key}) : super(key: key);

  @override
  _NotificationsPageWidgetState createState() =>
      _NotificationsPageWidgetState();
}

class _NotificationsPageWidgetState extends State<NotificationsPageWidget> {
  Completer<ApiCallResponse>? _apiRequestCompleter;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        leading: Icon(
          Icons.arrow_back,
          color: FlutterFlowTheme.of(context).primaryBackground,
          size: 28,
        ),
        title: Text(
          'Notifications',
          style: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'Open Sans',
                color: FlutterFlowTheme.of(context).primaryBackground,
                fontSize: 28,
              ),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 15, 15, 0),
            child: Text(
              'Clear All',
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Open Sans',
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    fontSize: 16,
                  ),
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
              FutureBuilder<ApiCallResponse>(
                future: (_apiRequestCompleter ??= Completer<ApiCallResponse>()
                      ..complete(GetEnrollmentsCall.call(
                        token: FFAppState().authToken,
                      )))
                    .future,
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          color: FlutterFlowTheme.of(context).primaryColor,
                        ),
                      ),
                    );
                  }
                  final listViewGetEnrollmentsResponse = snapshot.data!;
                  return Builder(
                    builder: (context) {
                      final enrollmentsList =
                          GetEnrollmentsCall.enrollmentsArray(
                        listViewGetEnrollmentsResponse.jsonBody,
                      ).toList();
                      return RefreshIndicator(
                        onRefresh: () async {
                          setState(() => _apiRequestCompleter = null);
                          await waitForApiRequestCompleter();
                        },
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: enrollmentsList.length,
                          itemBuilder: (context, enrollmentsListIndex) {
                            final enrollmentsListItem =
                                enrollmentsList[enrollmentsListIndex];
                            return Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(24, 24, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                          fontSize: 18,
                                        ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 0, 8),
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
                                                .primaryText,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                  Text(
                                    getJsonField(
                                      enrollmentsListItem,
                                      r'''$.id''',
                                    ).toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future waitForApiRequestCompleter({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = _apiRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
