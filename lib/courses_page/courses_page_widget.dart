import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:adapt_clicker/flutter_flow/app_router.gr.dart';
import 'package:adapt_clicker/utils/stored_preferences.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/api_requests/api_calls.dart';
import '../components/add_course_widget.dart';
import '../components/no_courses_widget.dart';
import '../components/drawer_ctn.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import '../utils/check_internet_connectivity.dart';
import '../flutter_flow/custom_functions.dart' as functions;

class CoursesPageWidget extends ConsumerStatefulWidget {
  final bool? isFirstScreen;

  const CoursesPageWidget({Key? key, this.isFirstScreen = false})
      : super(key: key);

  @override
  _CoursesPageWidgetState createState() => _CoursesPageWidgetState();
}

class _CoursesPageWidgetState extends ConsumerState<CoursesPageWidget> {
  ApiCallResponse? logout;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<ApiCallResponse>? _apiRequestCompleter;

  @override
  void initState() {
    // TODO: implement initState

    requestPermission(); //gets push notification permission
    getToken();
    firebaseID();
    super.initState();
  }

  //In app messaging ID
  void firebaseID() async {
    String id = await FirebaseInstallations.instance.getId();
    print(" Installation ID: $id");
  }

  //Permission check
  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized)
      print('User granted permission');
    else if (settings.authorizationStatus == AuthorizationStatus.provisional)
      print('User granted provisional permission');
    else
      print('User declined or has not accepted permission');
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        var mtoken = token;
        print("My token is $mtoken");
      });
    });
  }

  void saveToken(String token) async {
    //Fix me to work with API call
    await FirebaseFirestore.instance.collection("UserTokens").doc("User1").set({
      'token': token,
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isFirstScreen != null && widget.isFirstScreen == true) {
      final AsyncValue<ConnectivityStatus> connectivityStatusProvider =
          ref.watch(provider);
      ConnectivityStatus? status;
      connectivityStatusProvider.whenData((value) => {status = value});
      if (status != null) {
        if (status != ConnectivityStatus.isConnected) {
          ref.read(provider.notifier).startWatchingConnectivity();
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (status == null || status == ConnectivityStatus.initializing)
            return;
          functions.showSnackbar(context, status!);
        });
      }
    }

    return WillPopScope(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
          ),
          title: Text('Courses'),
          actions: [
            IconButton(
              icon: Icon(
                Icons.notifications,
              ),
              onPressed: () async {
                context.pushRoute(NotificationsRouteWidget());
              },
            ),
          ],
        ),
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Color(0x0E1862B3),
              context: context,
              builder: (context) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: AddCourseWidget(),
                );
              },
            );
          },
          backgroundColor: FlutterFlowTheme.of(context).primaryColor,
          elevation: 8,
          child: Icon(
            Icons.add,
            color: FlutterFlowTheme.of(context).primaryBackground,
            size: 28,
          ),
        ),
        drawer: DrawerCtnWidget(),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 26,
                decoration: BoxDecoration(
                  color: Color(0xFFD4D4D4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                      child: Text(
                        'active ',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ),
                    Text(
                      '(0)',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Open Sans',
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ],
                ),
              ),
              FutureBuilder<ApiCallResponse>(
                future: (_apiRequestCompleter ??= Completer<ApiCallResponse>()
                      ..complete(GetEnrollmentsCall.call(
                        token: StoredPreferences.authToken,
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
                              )?.toList() ??
                              '';
                      if (enrollmentsList.isEmpty) {
                        return Center(
                          child: NoCoursesWidget(),
                        );
                      }
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
                                  EdgeInsetsDirectional.fromSTEB(24, 24, 24, 0),
                              child: InkWell(
                                onTap: () async {
                                  context.pushRoute(AssignmentsRouteWidget(
                                    courseNumber: getJsonField(
                                      enrollmentsListItem,
                                      r'''$.id''',
                                    ),
                                    course: enrollmentsListItem,
                                  ));
                                },
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
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
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
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 24),
                                      child: Text(
                                        getJsonField(
                                          enrollmentsListItem,
                                          r'''$.id''',
                                        ).toString(),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Open Sans',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                    Divider(
                                      height: 1,
                                      thickness: 1,
                                    ),
                                  ],
                                ),
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
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
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
