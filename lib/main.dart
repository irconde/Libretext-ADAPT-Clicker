import 'dart:io';
import 'dart:ui';
import 'package:adapt_clicker/backend/push_notification_manager.dart';
import 'package:adapt_clicker/backend/router/app_router.gr.dart';
import 'package:adapt_clicker/backend/user_stored_preferences.dart';
import 'package:adapt_clicker/utils/firebase_message.dart';
import 'package:adapt_clicker/utils/firebase_message_adapter.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'backend/firebase/firebase_api.dart';
import 'constants/colors.dart';
import 'constants/strings.dart';
import 'mixins/connection_state_mixin.dart';
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
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

late FirebaseAPI firebaseAPI;
final appBarKey = GlobalKey();

///Firebase Methods that can't stay in a class
@pragma('vm:entry-point')
Future<void> handleBackground(RemoteMessage message) async {
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(FirebaseMessageAdapter());
  }
  final appDocumentsDirectory = await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter('${appDocumentsDirectory.path}/hive');
  Box? box = null;
  if (!Hive.isBoxOpen('notificationBox')) {
     box = await Hive.openBox<FirebaseMessage>('notificationBox');
  }
  await Firebase.initializeApp();
  FirebaseMessage msg = FirebaseMessage(title: message.notification!.title, body: message.notification!.body, route: message.data['path']);

  if(box != null) await box!.add(msg);
  await Hive.close();

  logger.i("Message maid it through");
}

Future<void> handlePendingMessages() async
{
  try {
    Future.delayed(Duration(milliseconds: 200));
    await PushNotificationManager().resetNotificationList();
    await FlutterLocalNotificationsPlugin().cancelAll();
  }
  catch(e)
  {
    logger.e(e);
  }
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

class MyApp extends ConsumerStatefulWidget  {

  const MyApp({Key? key, required this.authenticated}) : super(key: key);  @override

  final bool authenticated;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp>
    with ConnectionStateMixin, WidgetsBindingObserver  {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    tokenHandling();
    FlutterLocalNotificationsPlugin().cancelAll();
    PushNotificationManager().addListener(() {   setState((){});});

    if(widget.authenticated) {
      _showSignInSnackbar();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  Future<void> tokenHandling() async
  {
    firebaseAPI.getToken(setState);
    firebaseAPI.sendToken();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      await handlePendingMessages();

      setState(() {

        refreshConnection(); //resets internet connection
        appBarKey.currentState?.setState(() {
        });
      });
    }
  }

  final ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    startWatchingConnection();

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
          initialRoutes: widget.authenticated
              ? [CourseListScreen()]
              : [HomeScreen()]),
      routeInformationParser: AppState().router.defaultRouteParser(),
    );
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
}



