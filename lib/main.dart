import 'package:adapt_clicker/stored_preferences.dart';

import '../backend/api_requests/api_calls.dart';
import 'package:adapt_clicker/flutter_flow/custom_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'flutter_flow/app_router.gr.dart';
import 'package:flutter/scheduler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
  ));
  // This removes the bottom navigation and fills the empty space
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  await StoredPreferences.init();
  AppState();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = ThemeMode.system;
  ApiCallResponse? timezoneAttempt;
  ApiCallResponse? getUser;
  final _appRouter = AppRouter();
  late bool isSignedIn = false;

  void setLocale(String language) =>
      setState(() => _locale = createLocale(language));
  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
      });

  Future<void> fetchTimezone() async {
    final response = await GetTimezonesCall.call(); //contact server

    if (response.succeeded) {
      // If the call to the server was successful, init timezones
      initTimezones(response.jsonBody);
    } else {
      // If that call was not successful, throw an error.
      throw Exception(getJsonField(response.jsonBody,
          r'''$.message''')); //message should give error message.
      //note all errors will be logged in backend for server-side fix
    }
  }

  @override
  void initState() {
    print("Init state");
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      bool _isSignedIn = false;
      bool _rememberMe = StoredPreferences.rememberMe;
      String _authToken = StoredPreferences.authToken;
      if (_rememberMe) {
        if (_authToken != '') {
          getUser = await GetUserCall.call(
            token: _authToken,
          );
          if ((getUser?.succeeded ?? true)) {
            _isSignedIn = true;
          }
        }
      }
      setState(() {
        if (_isSignedIn == false) {
          StoredPreferences.authToken = '';
        }
        isSignedIn = _isSignedIn;
      });
    });
    fetchTimezone();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'AdaptClicker',
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
        brightness: Brightness.light,
        inputDecorationTheme: FlutterFlowTheme.of(context).inputTheme(),
      ),
      themeMode: _themeMode,
      routerDelegate: _appRouter.delegate(
        initialRoutes: [
          if (!isSignedIn) WelcomeRouteWidget(),
          if (isSignedIn) CoursesRouteWidget(),
        ],
      ),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
