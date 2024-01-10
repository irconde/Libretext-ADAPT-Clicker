import 'dart:ui';
import 'package:adapt_clicker/backend/push_notification_manager.dart';
import 'package:adapt_clicker/backend/router/app_router.gr.dart';
import 'package:adapt_clicker/backend/user_stored_preferences.dart';
import 'package:adapt_clicker/utils/firebase_message.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'backend/firebase/firebase_api.dart';
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

late FirebaseAPI firebaseAPI;

///Firebase Methods that can't stay in a class
@pragma('vm:entry-point')
Future<void> handleBackground(RemoteMessage message) async {
  if(Firebase == null) {
    await Firebase.initializeApp();
  }

  FirebaseMessage msg =  FirebaseMessage(title: message.notification?.title, body: message.notification?.body, route: message.data['path']);
  await PushNotificationManager().initializePersistedState();
  PushNotificationManager().addNotification(msg);
  logger.i('adding message');
}

void handlePendingMessages() async
{
  logger.i('current value: ${PushNotificationManager().notificationCount()}');
}

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

  await initFirebase();
  await UserStoredPreferences.init();
  AppState();
  preloadSVGs();


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

Future<void> initFirebase() async
{
  // Firebase initialization

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  firebaseAPI = FirebaseAPI();
  await firebaseAPI.initNotifications();
  FirebaseMessaging.onBackgroundMessage(handleBackground);
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

late Box<FirebaseMessage> _notificationBox;
class _MyStatefulWidgetState extends State<MyStatefulWidget> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    tokenHandling();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
    _notificationBox.close();
  }

  Future<void> tokenHandling() async
  {
    firebaseAPI.getToken(setState);
    firebaseAPI.sendToken();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      handlePendingMessages();
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



