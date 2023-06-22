import 'package:adapt_clicker/backend/router/app_router.gr.dart';
import 'package:adapt_clicker/widgets/app_bars/main_app_bar_widget.dart';
import 'package:adapt_clicker/main.dart';
import 'package:adapt_clicker/widgets/shimmer/shim_pages.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:adapt_clicker/backend/user_stored_preferences.dart';
import 'package:auto_route/auto_route.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../backend/Router/app_router.dart';
import '../../backend/api_requests/api_calls.dart';
import '../../constants/strings.dart';
import '../../utils/Logger.dart';
import '../../utils/app_state.dart';
import '../../widgets/bottom_sheets/add_course_widget.dart';
import '../../mixins/connection_state_mixin.dart';
import 'no_courses_widget.dart';
import '../../widgets/navigation_drawer_widget.dart';
import '../../utils/app_theme.dart';
import 'dart:async';
import 'package:flutter/material.dart' hide Router;
import '../../constants/colors.dart';

@RoutePage()
class CourseListScreen extends ConsumerStatefulWidget {
  final bool? isFirstScreen;

  /// Constructs a [CourseListScreen] widget.
  ///
  /// [isFirstScreen] specifies whether this is the first screen.
  const CourseListScreen({Key? key, this.isFirstScreen = false})
      : super(key: key);

  @override
  ConsumerState<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends ConsumerState<CourseListScreen>
    with ConnectionStateMixin {
  ApiCallResponse? logout;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<ApiCallResponse>? _apiRequestCompleter;
  ApiCallResponse? sendTokenResponse;
  bool isLoading = true;

  /// Refreshes the page by calling [updateAndGetResponse].
  Future<bool> refreshPage() async {
    try {
      setState(() {
        _apiRequestCompleter = updateAndGetResponse();
      });
      return true;
    } catch (e) {
      logger.e(e.toString());
      return false;
    }
  }

  /// Calls the API to update the response and returns the updated response.
  Future<ApiCallResponse> updateAndGetResponse() async {
    var response = GetEnrollmentsCall.call(
      token: UserStoredPreferences.authToken,
    );

    await response;
    setState(() {
      isLoading = false;
    });
    return response;
  }

  @override
  void initState() {
    super.initState();
    initFirebase();
    requestPermission(); //gets push notification permission
    getToken();
    sendToken();
    handleRoutes();
    _apiRequestCompleter = updateAndGetResponse();
    if (widget.isFirstScreen!) {
      _showSignInSnackbar();
    }
  }

  /// Shows a snackbar indicating the signed-in user.
  void _showSignInSnackbar() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: RichText(
              text: TextSpan(
                text: Strings.signedInAs,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: UserStoredPreferences.userAccount,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: '.'),
                ],
              ),
            ),
            backgroundColor: CColors.secondaryText),
      );
    });
  }

  /// Initializes Firebase services.
  Future<void> initFirebase() async {
    FirebaseMessaging.instance.setDeliveryMetricsExportToBigQuery(true);
    //FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    //String id = await FirebaseInstallations.instance.getId();
  }

  /// Requests push notification permission.
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
      logger.d('User granted permission');
    } else if (await Permission.notification.status.isLimited) {
      logger.d('User granted provisional permission');
    } else {
      logger.d('User declined or has not accepted permission');
    }
  }

  /// Handles incoming push notification routes.
  void handleRoutes() {
    RouteHandler rh = RouteHandler();
    // Handle incoming push notifications when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      logger.d('Got a message whilst in the foreground!');
      logger.d('Message data: ${message.data}');
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
      logger.d('A new onMessageOpenedApp event was published!');
      logger.d('Message data: ${message.data}');
      // Extract the route parameter from the message
      String path = message.data['path'];
      List<String> data = [message.data['id']];
      String args = await rh.getArgs(path, data);
      // If the message contains a route parameter, navigate to the corresponding route
      rh.navigateTo(context, path, args);
    });
  }

  /// Saves the Firebase token.
  void saveToken(var token) async {
    UserStoredPreferences.setString('ff_deviceIDToken', token);
    logger.d('My token is $token');
  }

  /// Retrieves the Firebase token.
  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        var mToken = token;
        saveToken(mToken);
      });
    });
  }

  /// Sends the Firebase token to the server.
  Future<void> sendToken() async {
    sendTokenResponse = await SendTokenCall.call(
      token: UserStoredPreferences.authToken,
      fcmToken: UserStoredPreferences.deviceIDToken,
    );
    logger.d(sendTokenResponse?.jsonBody.toString());
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isFirstScreen!) {
      startWatchingConnection();
    }
    return WillPopScope(
      child: Scaffold(
        key: scaffoldKey,
        appBar: MainAppBar(
            title: Strings.courses,
            scaffoldKey: scaffoldKey,
            setState: (VoidCallback fn) {
              setState(fn);
            }),
        backgroundColor: CColors.primaryBackground,
        floatingActionButton: isLoading
            ? FloatingActionButton(
                onPressed: () {},
                backgroundColor: CColors.buttonShimmerBackground,
                elevation: 8,
                child: const Icon(
                  Icons.add,
                  color: CColors.primaryBackground,
                  size: 28,
                ),
              )
            : FloatingActionButton(
                onPressed: () async {
                  if (!checkConnection()) return;
                  showModalBottomSheet(
                    useSafeArea: true,
                    isScrollControlled: true,
                    backgroundColor: CColors.blurColor,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: const AddCourseWidget(),
                      );
                    },
                  ).then((value) => {refreshPage()});
                },
                backgroundColor: CColors.primaryColor,
                elevation: 8,
                child: const Icon(
                  Icons.add,
                  color: CColors.primaryBackground,
                  size: 28,
                ),
              ),
        drawer:
            const NavigationDrawerWidget(currentSelected: DrawerItems.courses),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: isLoading
              ? shimCourses(setState: setState, context: context)
              : loadedPage(),
        ),
      ),
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
    );
  }

  /// Widget to display the loaded page content.
  Widget loadedPage() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        FutureBuilder<ApiCallResponse>(
          key: const Key('Course List'),
          future: _apiRequestCompleter,
          builder: (context, snapshot) {
            // Customize what your widget looks like when it's loading.
            if (!snapshot.hasData) {
              return const Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    color: CColors.primaryColor,
                  ),
                ),
              );
            }
            final listViewGetEnrollmentsResponse = snapshot.data!;
            return Builder(
              builder: (context) {
                final enrollmentsList = GetEnrollmentsCall.enrollmentsArray(
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
                          if (!checkConnection()) return;
                          context.pushRoute(AssignmentsRouteWidget(
                              id: enrollmentsListItem['id'].toString()));
                        },
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24, 24, 24, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                enrollmentsListItem['course_section_name'],
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Open Sans',
                                      color: CColors.primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 8, 0, 24),
                                child: Text(
                                  enrollmentsListItem['instructor'],
                                  style:
                                      AppTheme.of(context).bodyText1.override(
                                            fontFamily: 'Open Sans',
                                            color: CColors.secondaryText,
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
    );
  }
}
