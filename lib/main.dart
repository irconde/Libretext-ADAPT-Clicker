import 'dart:ui';

import 'package:adapt_clicker/backend/router/app_router.gr.dart';
import 'package:adapt_clicker/utils/stored_preferences.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import '../backend/api_requests/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'backend/router/app_router.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Firebase/firebase_options.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger(
  filter: null,
  printer: PrettyPrinter(),
  output: null,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  // Set preferred screen orientations to portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  bool isAuthenticated;
  try {
    isAuthenticated = await userIsAuthenticated();
  } catch (e) {
    logger.e(e.toString());
    isAuthenticated = false;
  }
  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //FirebaseMessaging.onMessage.listen(_firebaseMessagingBackgroundHandler);
  await StoredPreferences.init();
  AppState();
  functions.preloadSVGs();
  // Firebase initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(ProviderScope(child: MyApp(authenticated: isAuthenticated)));
}

Future<bool> userIsAuthenticated() async {
  bool isSignedIn = false;
  await StoredPreferences.init();
  bool rememberMe = StoredPreferences.rememberMe;
  String userAccount = StoredPreferences.userAccount;
  String userPassword = StoredPreferences.userPassword;
  String currentToken = StoredPreferences.authToken;
  if (rememberMe) {
    if (userAccount.isNotEmpty && userPassword.isNotEmpty) {
      ApiCallResponse loginAttempt = await LoginCall.call(
        email: userAccount,
        password: userPassword,
      );
      if ((loginAttempt.succeeded)) {
        isSignedIn = true;
        String newToken = functions.createToken(getJsonField(
          (loginAttempt.jsonBody ?? ''),
          r'''$.token''',
        ).toString());
        if (newToken != currentToken) {
          StoredPreferences.authToken = newToken;
        }
      }
    }
  }
  if (isSignedIn == false) {
    StoredPreferences.authToken = '';
  }
  return Future(() => isSignedIn);
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
      localizationsDelegates: const [
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
      routeInformationProvider: _appRouter.routeInfoProvider(),
      routerDelegate: _appRouter.delegate(
          initialRoutes: authenticated
              ? [CoursesRouteWidget(isFirstScreen: true)]
              : [WelcomeRouteWidget(isFirstScreen: true)]),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
