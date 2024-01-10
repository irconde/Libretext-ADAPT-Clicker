import 'package:adapt_clicker/utils/firebase_message.dart';
import 'package:adapt_clicker/utils/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../constants/colors.dart';
import '../../utils/logger.dart';
import '../../utils/app_state.dart';
import '../../widgets/bottom_sheets/notification_popup.dart';
import '../Router/app_router.dart';
import '../api_requests/api_calls.dart';
import 'package:rxdart/rxdart.dart';
import '../user_stored_preferences.dart';

class FirebaseAPI {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _firebaseInAppMessaging = FirebaseInAppMessaging.instance;
  final _messageStreamController = BehaviorSubject<RemoteMessage>();
  ApiCallResponse? sendTokenResponse;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    //permissionLog();

    _firebaseInAppMessaging.setMessagesSuppressed(false);

    _firebaseMessaging.setDeliveryMetricsExportToBigQuery(true);

    initPushNotifications();
    final fCMToken = await _firebaseMessaging.getToken();
    logger.d('Token: $fCMToken');
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

  bool isOutside = false;

  List<RemoteMessage> pendingMessages = [];

  void handleMessage(RemoteMessage? message) {

    if (message == null) return;

    handleMostRecentMessage(message);

    // Notify listeners or perform additional actions as needed
    _messageStreamController.sink.add(message);
  }

  void handleMostRecentMessage(RemoteMessage message) async
  {
    logger.w('Got a message whilst in the foreground! ${message.from.toString()}');
    logger.d('Message data: ${message.data}');

    handleParsed(parseLink(message.data['path']), message);
    // Extract the route parameter from the message
  }

  Future<void> handleParsed(Map<String, dynamic>? parsedData, RemoteMessage? message) async {
    if (parsedData != null) {
      String path = parsedData['path'];
      List<String> data = parsedData['args'];

      logger.i('Path: $path');
      logger.i('Args: $data');

      String args = await RouteHandler.getArgs(path, data); //makes sense of args depending on page

      if (!isOutside) {
        showPopup(
          message?.notification?.title ?? 'Notification',
          message?.notification?.body ?? '',
          '$path/$args',
        );
      } else {
        isOutside = false;
        RouteHandler.navTo('$path/$args');
      }
    } else {
      logger.w('Invalid link format');
    }
  }

  void showPopup(String title, String description, String route) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: CColors.blurColor,
      context: AppState().router.navigatorKey.currentContext!,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: NotificationPopup(title, description, route),
        );
      },
    );
  }

  Map<String, dynamic>? parseLink(String link) {
    // Split the link using '/' as the delimiter
    List<String> parts = link.split('/');

    // Check if the number of parts is at least 2 (path and one argument)
    if (parts.isNotEmpty) {
      String path = '/${parts[0]}'; // The path is the second part
      List<String> args = [];
      for (int i = 1; i < parts.length; i++) {
        args.add(parts[i]);
      } // The remaining parts are arguments

      return {'path': path, 'args': args};
    } else {
      return null; // Invalid link format
    }
  }

  //routes
  /// Handles incoming push notification routes.
  Future initPushNotifications() async {
    await _firebaseMessaging.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessage.listen(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      isOutside = true;
      handleMessage(message);
    });

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
