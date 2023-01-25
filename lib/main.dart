import 'package:adapt_clicker/stored_preferences.dart';
import 'package:auto_route/auto_route.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import '../backend/api_requests/api_calls.dart';
import 'package:adapt_clicker/flutter_flow/custom_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'flutter_flow/app_router.gr.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
  ));
  // This removes the bottom navigation and fills the empty space
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  bool isAuthenticated = await userIsAuthenticated();
  AppState();
  fetchTimezone();
  runApp(MyApp(authenticated: isAuthenticated));
}

Future<bool> userIsAuthenticated() async {
  bool _isSignedIn = false;
  await StoredPreferences.init();
  bool _rememberMe = StoredPreferences.rememberMe;
  String _userAccount = StoredPreferences.userAccount;
  String _userPassword = StoredPreferences.userPassword;
  String _currentToken = StoredPreferences.authToken;
  if (_rememberMe) {
    if (_userAccount.isNotEmpty && _userPassword.isNotEmpty) {
      ApiCallResponse loginAttempt = await LoginCall.call(
        email: _userAccount,
        password: _userPassword,
      );
      if ((loginAttempt?.succeeded ?? true)) {
        _isSignedIn = true;
        String _newToken = functions.createToken(getJsonField(
          (loginAttempt?.jsonBody ?? ''),
          r'''$.token''',
        ).toString());
        if (_newToken != _currentToken) {
          StoredPreferences.authToken = _newToken;
        }
      }
    }
  }
  if (_isSignedIn == false) {
    StoredPreferences.authToken = '';
  }
  return Future(() => _isSignedIn);
}

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

class MyApp extends StatelessWidget {
  final ThemeMode _themeMode = ThemeMode.system;
  final _appRouter = AppRouter();
  final bool authenticated;

  MyApp({Key? key, required this.authenticated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'LibreTexts ADAPT',
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
        brightness: Brightness.light,
        inputDecorationTheme: FlutterFlowTheme.of(context).inputTheme(),
      ),
      themeMode: _themeMode,
      routerDelegate: AutoRouterDelegate.declarative(
        _appRouter,
        routes: (_) => [
          // if the user is logged in, they may proceed to the course list
          if (authenticated)
            CoursesRouteWidget()
          // if they are not logged in, bring them to the Welcome page
          else
            WelcomeRouteWidget()
        ],
      ),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
