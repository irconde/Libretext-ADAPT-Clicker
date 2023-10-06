import 'package:adapt_clicker/backend/Router/app_router.dart';
import 'package:adapt_clicker/backend/firebase/FirebaseAPI.dart';
import 'package:adapt_clicker/backend/router/app_router.gr.dart';
import 'package:adapt_clicker/widgets/app_bars/main_app_bar_widget.dart';
import 'package:adapt_clicker/widgets/shimmer/shim_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:adapt_clicker/backend/user_stored_preferences.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../backend/api_requests/api_calls.dart';
import '../../constants/strings.dart';
import '../../utils/Logger.dart';
import '../../utils/utils.dart';
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
  CourseListScreen({Key? key, this.isFirstScreen = false, @QueryParam('token') token = ''})
      : super(key: key);
  String? token;
  @override
  ConsumerState<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends ConsumerState<CourseListScreen>
    with ConnectionStateMixin {
  ApiCallResponse? logout;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<ApiCallResponse>? _apiRequestCompleter;

  bool isLoading = true;

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
    init();

  }

  void init() async {
    await createTokenFromPath();
    initJWT();
    initMessages();
    _apiRequestCompleter = updateAndGetResponse();
    if (widget.isFirstScreen!) {
      _showSignInSnackbar();
    }
  }

  void initMessages()
  {
    FirebaseAPI firebase = FirebaseAPI();
    firebase.getToken(setState);
    firebase.sendToken();
  }

  late URLRequest request;
  Future<void> initJWT() async {
    request = URLRequest(
      url: Uri.parse(
          'https://adapt.libretexts.org/api/users/set-cookie-user-jwt'),
      headers: {'authorization': UserStoredPreferences.authToken},
    );
  }

  Future<void> createTokenFromPath() async {
    //Gets token from query parameter
    widget.token = context.routeData.queryParams.getString('token');
    if (widget.token == null || widget.token == '') {
      return;
    }
    String token = createToken(widget.token!);
    await UserStoredPreferences.setString('ff_authToken', token);
    if (UserStoredPreferences.authToken == null) {
      await context.pushRoute(const LoginScreenWidget());
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


                  /*if (!checkConnection()) return;
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
                  ).then((value) => {refreshPage()});*/
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
                          context.pushRoute(CourseDetailsScreen(
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
                              Visibility(
                                visible: false,
                                maintainState: true,
                                child: SizedBox(
                                  height: 20,
                                  child: InAppWebView(
                                    initialUrlRequest: request,
                                    onWebViewCreated: (controller) {
                                      webViewController = controller;
                                      //controller.loadUrl(urlRequest: requestJWT);
                                      //logger.i(UserStoredPreferences.authToken );
                                    },
                                    onLoadStop: (controller, uri) async {
                                      List<Cookie> cookies =
                                      await _cookieManager.getCookies(url: request.url!);
                                      cookies.forEach((cookie) {
                                        if (cookie.name == 'user_jwt') {
                                          AppState().cookie = cookie;
                                          //logger.i(cookie.name + " " + cookie.value);
                                        }
                                      });
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
}
