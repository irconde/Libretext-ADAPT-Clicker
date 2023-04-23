import 'package:adapt_clicker/backend/router/app_router.gr.dart';
import 'package:adapt_clicker/components/main_app_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:adapt_clicker/utils/stored_preferences.dart';
import 'package:auto_route/auto_route.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/Router/app_router.dart';
import '../backend/api_requests/api_calls.dart';
import '../components/add_course_widget.dart';
import '../components/no_courses_widget.dart';
import '../components/drawer_ctn.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'package:flutter/material.dart' hide Router;
import '../utils/check_internet_connectivity.dart';
import '../flutter_flow/custom_functions.dart' as functions;

@RoutePage()
class CoursesPageWidget extends ConsumerStatefulWidget {
  final bool? isFirstScreen;

  const CoursesPageWidget({Key? key, this.isFirstScreen = false})
      : super(key: key);

  @override
  ConsumerState<CoursesPageWidget> createState() => _CoursesPageWidgetState();
}

class _CoursesPageWidgetState extends ConsumerState<CoursesPageWidget> {
  ApiCallResponse? logout;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<ApiCallResponse>? _apiRequestCompleter;
  ApiCallResponse? sendTokenResponse;

  Future<bool> refreshPage() async {
    try {
      setState(() {
        _apiRequestCompleter = updateAndGetResponse();
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<ApiCallResponse> updateAndGetResponse() {
    return GetEnrollmentsCall.call(
      token: StoredPreferences.authToken,
    );
  }

  bool _checkConnection() {
    ConnectivityStatus? status =
        ref.read(provider.notifier).getConnectionStatus();
    if (status != ConnectivityStatus.isConnected) {
      functions.showSnackbar(context, status);
      return false;
    }
    return true;
  }

  @override
  void initState() {
    initFirebase();
    requestPermission(); //gets push notification permission
    getToken();
    sendToken();
    handleRoutes();
    _apiRequestCompleter = updateAndGetResponse();
    super.initState();
  }

  //Creating Firebase
  Future<void> initFirebase() async {
    FirebaseMessaging.instance.setDeliveryMetricsExportToBigQuery(true);
    //FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    //String id = await FirebaseInstallations.instance.getId();
  }

  //Permission check
  void requestPermission() async {
    // TODO. To be deleted? This is not being used.
    // FirebaseMessaging messaging = FirebaseMessaging.instance;
    // TODO. To be deleted? This is not being used.
    /*
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
     */

    if (await Permission.notification.request().isGranted) {
      // TODO. To be deleted
      // print('User granted permission');
    } else if (await Permission.notification.status.isLimited) {
      // TODO. To be deleted
      // print('User granted provisional permission');
    } else {
      // TODO. To be deleted
      // print('User declined or has not accepted permission');
    }
  }

  void handleRoutes() {
    RouteHandler rh = RouteHandler();
    // Handle incoming push notifications when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      // Extract the route parameter from the message
      String path = message.data['path'];
      String id = message.data['id'];
      List<String> data = [id];
      String args = await rh.getArgs(path, data);
      // If the message contains a route parameter, navigate to the corresponding route
      rh.navigateTo(context, path, args);
    });
    // Handle push notification when opening it
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('A new onMessageOpenedApp event was published!');
      print('Message data: ${message.data}');
      // Extract the route parameter from the message
      String path = message.data['path'];
      List<String> data = [message.data['id']];
      String args = await rh.getArgs(path, data);
      // If the message contains a route parameter, navigate to the corresponding route
      rh.navigateTo(context, path, args);
    });
  }

  void saveToken(var token) async {
    StoredPreferences.setString('ff_deviceIDToken', token);
    // TODO. To be deleted
    //print("My token is " + token);
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        var mtoken = token;
        saveToken(mtoken);
      });
    });
  }

  Future<void> sendToken() async {
    sendTokenResponse = await SendTokenCall.call(
      token: StoredPreferences.authToken,
      fcmToken: StoredPreferences.deviceIDToken,
    );
    // TODO. To be deleted
    // print(sendTokenResponse?.jsonBody.toString());
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
          if (status == null || status == ConnectivityStatus.initializing) {
            return;
          }
          functions.showSnackbar(context, status!);
        });
      }
    }

    return WillPopScope(
      child: Scaffold(
        key: scaffoldKey,
        appBar: MainAppBar(
            title: 'Courses',
            scaffoldKey: scaffoldKey,
            setState: (VoidCallback fn) {
              setState(fn);
            }),
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (!_checkConnection()) return;

            showModalBottomSheet(
              useSafeArea: true,
              isScrollControlled: true,
              backgroundColor: const Color(0x0E1862B3),
              context: context,
              builder: (context) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: const AddCourseWidget(),
                );
              },
            ).then((value) => {refreshPage()});
          },
          backgroundColor: FlutterFlowTheme.of(context).primaryColor,
          elevation: 8,
          child: Icon(
            Icons.add,
            color: FlutterFlowTheme.of(context).primaryBackground,
            size: 28,
          ),
        ),
        drawer: const DrawerCtnWidget(currentSelected: DrawerItems.courses),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              FutureBuilder<ApiCallResponse>(
                key: const Key('Course List'),
                future: _apiRequestCompleter,
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
                        return const NoCoursesWidget();
                      }
                      return RefreshIndicator(
                        onRefresh: () async {
                          setState(() => _apiRequestCompleter = null);
                          await refreshPage();
                        },
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: enrollmentsList.length,
                          itemBuilder: (context, enrollmentsListIndex) {
                            final enrollmentsListItem =
                                enrollmentsList[enrollmentsListIndex];
                            return InkWell(
                              onTap: () async {
                                if (!_checkConnection()) return;
                                context.pushRoute(AssignmentsRouteWidget(
                                  course: enrollmentsListItem,
                                ));
                              },
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    24, 24, 24, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getJsonField(
                                        enrollmentsListItem,
                                        r'''$.course_section_name''',
                                      ).toString().split('-')[0],
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
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 8, 0, 24),
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
                                    const Divider(
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
}
