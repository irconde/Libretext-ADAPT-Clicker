import 'package:adapt_clicker/utils/stored_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:adapt_clicker/stored_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
import 'package:firebase_core/firebase_core.dart';
import 'Firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  bool isAuthenticated = false;
  try {
    isAuthenticated = await userIsAuthenticated();
  } catch (e) {}
  AppState();
  fetchTimezone();
  functions.preloadSVGs();
  // Firebase initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      if ((loginAttempt.succeeded)) {
        _isSignedIn = true;
        String _newToken = functions.createToken(getJsonField(
          (loginAttempt.jsonBody ?? ''),
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
        appBarTheme: FlutterFlowTheme.of(context).appBarTheme(),
      ),
      themeMode: _themeMode,
      routerDelegate: _appRouter.delegate(
          initialRoutes: authenticated
              ? [CoursesRouteWidget(isFirstScreen: true)]
              : [WelcomeRouteWidget(isFirstScreen: true)]),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
