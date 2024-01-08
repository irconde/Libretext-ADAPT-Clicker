import 'dart:ui';
import 'package:adapt_clicker/backend/firebase/firebase_api.dart';
import 'package:adapt_clicker/backend/router/app_router.gr.dart';
import 'package:adapt_clicker/backend/user_stored_preferences.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'utils/logger.dart';
import 'utils/utils.dart';
import '../backend/api_requests/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'utils/app_theme.dart';
import 'utils/internationalization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'backend/firebase/firebase_options.dart';


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
  await UserStoredPreferences.init();
  AppState();
  preloadSVGs();
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
  await UserStoredPreferences.init();
  bool rememberMe = UserStoredPreferences.rememberMe;
  String userAccount = UserStoredPreferences.userAccount;
  String userPassword = UserStoredPreferences.userPassword;
  String currentToken = UserStoredPreferences.authToken;
  if (rememberMe) {
    if (userAccount.isNotEmpty && userPassword.isNotEmpty) {
      ApiCallResponse loginAttempt = await LoginCall.call(
        email: userAccount,
        password: userPassword,
      );
      if ((loginAttempt.succeeded)) {
        isSignedIn = true;
        String newToken = createToken(getJsonField(
          (loginAttempt.jsonBody ?? ''),
          r'''$.token''',
        ).toString());
        if (newToken != currentToken) {
          UserStoredPreferences.authToken = newToken;
        }
      }
    }
  }
  if (isSignedIn == false) {
    UserStoredPreferences.authToken = '';
  }
  return Future(() => isSignedIn);
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key, required this.authenticated}) : super(key: key);  @override

  final bool authenticated;
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyStatefulWidget(authenticated: authenticated),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {



  const MyStatefulWidget({required this.authenticated});
  final bool authenticated;
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState(authenticated: authenticated);
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App has come to the foreground, check for pending notifications
      FirebaseAPI api = FirebaseAPI();
      api.handlePendingMessages();
    }
  }

  final ThemeMode _themeMode = ThemeMode.system;
  final bool authenticated;

  _MyStatefulWidgetState({required this.authenticated});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'LibreTexts ADAPT',
      localizationsDelegates: const [
        LBTXTLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
        brightness: Brightness.light,
        inputDecorationTheme: AppTheme.of(context).inputTheme(),
        appBarTheme: AppTheme.of(context).appBarTheme(),
      ),
      themeMode: _themeMode,
      routeInformationProvider: AppState().router.routeInfoProvider(),
      routerDelegate: AppState().router.delegate(
          initialRoutes: authenticated
              ? [CourseListScreen(isFirstScreen: true)]
              : [HomeScreen(isFirstScreen: true)]),
      routeInformationParser: AppState().router.defaultRouteParser(),
    );
  }
}
