import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../main.dart';
import '../../utils/Logger.dart';
import '../Router/app_router.dart';
import '../api_requests/api_calls.dart';
import '../api_requests/api_manager.dart';
import 'package:rxdart/rxdart.dart';
import '../user_stored_preferences.dart';

class FirebaseAPI {
  final _firebaseMessaging  = FirebaseMessaging.instance;
  final _firebaseInAppMessaging = FirebaseInAppMessaging.instance;
  final _messageStreamController = BehaviorSubject<RemoteMessage>();
  ApiCallResponse? sendTokenResponse;

  Future<void> initNotifications() async {

    await _firebaseMessaging.requestPermission();
    permissionLog();
    //final fCMToken = await _firebaseMessaging.getToken();

    _firebaseInAppMessaging.setMessagesSuppressed(false);

    _firebaseMessaging.setDeliveryMetricsExportToBigQuery(true);

    initPushNotifications();

    //print('Token: $fCMToken');


  }

  /// Requests push notification permission.
  void permissionLog() async {
    if (await Permission.notification.request().isGranted) {
      logger.d('User granted permission');
    } else if (await Permission.notification.status.isLimited) {
      logger.d('User granted provisional permission');
    } else {
      logger.d('User declined or has not accepted permission');
    }
  }

  //Function for messages
  void handleMessage(RemoteMessage? message) async
  {
      if(message == null) return;
      RouteHandler rh = RouteHandler();
      logger.w('Got a message whilst in the foreground!');
      logger.d('Message data: ${message.data}');

      Map<String, dynamic>? parsedData = parseLink(message.data['path']);
      // Extract the route parameter from the message
      if (parsedData != null) {
        String path = parsedData['path'];
        List<String> data = parsedData['args'];

        logger.d('Path: $path');
        logger.d('Args: $data');

        String args = await rh.getArgs(path, data);
        // If the message contains a route parameter, navigate to the corresponding route
        rh.navigateTo(path, args);
      } else {
        logger.w('Invalid link format');
      }

      _messageStreamController.sink.add(message);
  }

  Map<String, dynamic>? parseLink(String link) {
    // Split the link using '/' as the delimiter
    List<String> parts = link.split('/');

    // Check if the number of parts is at least 2 (path and one argument)
    if (parts.isNotEmpty) {
      String path = '/' + parts[1]; // The path is the second part
      List<String> args = parts.sublist(2); // The remaining parts are arguments

      return {'path': path, 'args': args};
    } else {
      return null; // Invalid link format
    }
  }


  //routes
  /// Handles incoming push notification routes.
  Future initPushNotifications() async{
    _firebaseMessaging.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessage.listen(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }


  /// Saves the Firebase token.
  void saveToken(var token) async {
    UserStoredPreferences.setString('ff_deviceIDToken', token);
    logger.d('My token is $token');
  }

  /// Retrieves the Firebase token.
  void getToken(Function setState) async {
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
}