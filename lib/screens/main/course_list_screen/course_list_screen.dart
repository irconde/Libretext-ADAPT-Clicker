import 'package:adapt_clicker/backend/firebase/firebase_api.dart';
import 'package:adapt_clicker/backend/router/app_router.gr.dart';
import 'package:adapt_clicker/constants/dimens.dart';
import 'package:adapt_clicker/constants/icons.dart';
import 'package:adapt_clicker/widgets/app_bars/main_app_bar_widget.dart';
import 'package:adapt_clicker/widgets/shimmer/shim_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:adapt_clicker/backend/user_stored_preferences.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'no_courses_widget.dart';
import 'dart:async';
import 'package:flutter/material.dart' hide Router;
import '../../../mixins/connection_state_mixin.dart';
import '../../../widgets/bottom_sheets/add_course_widget.dart';
import '../../../widgets/navigation_drawer_widget.dart';
import '../../../backend/api_requests/api_calls.dart';
import '../../../utils/app_theme.dart';
import '../../../constants/colors.dart';
import '../../../constants/strings.dart';
import '../../../utils/logger.dart';
import '../../../utils/utils.dart';

/// Course List Screen
/// Displays List Of Courses, Allows Adding Of Course, and Navigation amongst other major pages
/// Page Enables Notifications and Checks For tokens.

@RoutePage()
class CourseListScreen extends ConsumerStatefulWidget {
  CourseListScreen({Key? key, @QueryParam('token') token = ''})
      : super(key: key);

  String? token;

  @override
  ConsumerState<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends ConsumerState<CourseListScreen> with ConnectionStateMixin{


  final scaffoldKey = GlobalKey<ScaffoldState>();

  //Local
  bool isLoading = true;

  //Libretext
  ApiCallResponse? logout;
  Future<ApiCallResponse>? _apiRequestCompleter;

  //Cookies
  InAppWebViewController? webViewController;
  final CookieManager _cookieManager = CookieManager.instance();
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
        supportZoom: true,
        javaScriptEnabled: true,
        javaScriptCanOpenWindowsAutomatically: true,
        cacheEnabled: true,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      )
  );

  ///Build
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (isLoading) { MoveToBackground.moveTaskToBack();},
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
          elevation: Dimens.floatingActionButtonElevation,
          child: IIcons.floating,
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
          elevation: Dimens.floatingActionButtonElevation,
          child: IIcons.floating,
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
    );
  }

  /// Widget to display the loaded page content.
  Widget loadedPage() {
    var theme = AppTheme.of(context);
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
                  if(listViewGetEnrollmentsResponse.jsonBody['message'] == 'Unauthenticated.')
                    {
                      Navigator.pop(context);
                      showAccountErrorSnackBar();
                    }
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
                          context.pushRoute(CourseDetailsScreen(
                              id: enrollmentsListItem['id'].toString()));
                        },
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              Dimens.msMargin, Dimens.msMargin, Dimens.msMargin, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                enrollmentsListItem['course_section_name'],
                                style: theme.bodyText1.override(
                                      fontFamily: 'Open Sans',
                                      color: CColors.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, Dimens.xsMargin, 0, Dimens.msMargin),
                                child: Text(
                                  enrollmentsListItem['instructor'],
                                  style:
                                      theme.bodyText2.override(
                                            fontFamily: 'Open Sans',
                                            fontWeight: FontWeight.w600,
                                          ),
                                ),
                              ),
                              const Divider(
                                height: Dimens.dividerHeight,
                               ),
                              Visibility(
                                visible: false,
                                maintainState: true,
                                child: SizedBox(
                                  height: 1,
                                  child: InAppWebView(
                                    initialUrlRequest: request,
                                    onWebViewCreated: (controller) {
                                      webViewController = controller;
                                    },
                                    onLoadStop: (controller, uri) async {
                                      List<Cookie> cookies =
                                      await _cookieManager.getCookies(url: request.url!);
                                      for (var cookie in cookies) {
                                        if (cookie.name == 'user_jwt') {
                                          AppState().cookie = cookie;
                                        }
                                      }
                                    },
                                    initialOptions: options,
                                    gestureRecognizers: Set()
                                      ..add(Factory(() => EagerGestureRecognizer()))
                                      ..add(Factory<VerticalDragGestureRecognizer>(
                                              () => VerticalDragGestureRecognizer())),
                                  ),
                                ),
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

  ///Functions
  @override
  void initState() {
    super.initState();
    init();
  }


  void init() async {

    FirebaseAPI firebaseAPI = new FirebaseAPI();
    await firebaseAPI.initNotifiactions();
    await createTokenFromPath();
    await refreshPage();
    await initJWT();
  }

  Future<void> createTokenFromPath() async {
    //Gets token from query parameter
    widget.token = context.routeData.queryParams.getString('token');
    if (widget.token == null || widget.token == '') return;
    String token = createToken(widget.token!);
    await UserStoredPreferences.setString('ff_authToken', token);
    if (UserStoredPreferences.authToken.isEmpty) {
      await AppState().router.push(const LoginScreenWidget());
    }
  }

  ///Handles Account Error
  void showAccountErrorSnackBar()
  {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          Strings.accountError,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        backgroundColor: CColors.failure,
      ),
    );
  }

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

  late URLRequest request;
  Future<void> initJWT() async {
    request = URLRequest(
      url: Uri.parse(
          '${Strings.adaptLink}/api/users/set-cookie-user-jwt'),
      headers: {'authorization': UserStoredPreferences.authToken},
    );
  }





}
