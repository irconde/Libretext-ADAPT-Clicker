import 'dart:async';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:adapt_clicker/utils/firebase_message.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import '../utils/firebase_message_adapter.dart';
import '../utils/logger.dart';

/// A class that manages push notifications and persists the notification list using SharedPreferences.
class PushNotificationManager extends ChangeNotifier{

  static PushNotificationManager? _instance;
  Box? notificationBox;
  static List<FirebaseMessage> _notificationList = [];
  Isolate? isolate;

  // Declare a factory constructor that returns the singleton instance
  factory PushNotificationManager() {
    // If the instance is null, create a new one
    _instance ??= PushNotificationManager._();
    // Return the instance
    return _instance!;
  }


  PushNotificationManager._()
  {
    initializePersistedState();
  }


  /// Initializes the persisted state by retrieving the notification list from SharedPreferences.
  Future initializePersistedState() async {
    await initHive();
    }

  Future<void> initHive() async
  {
    // Initialize Hive
    final appDocumentsDirectory = await path_provider.getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentsDirectory.path);

    if(!Hive.isAdapterRegistered(FirebaseMessageAdapter().typeId)) {
      Hive.registerAdapter(
          FirebaseMessageAdapter()); // Make sure to register the adapter
    }

    await openBox();
  }

  Future<void> openBox() async
  {
    notificationBox = await Hive.openBox<FirebaseMessage>('notificationBox');
    _notificationList =  notificationBox!.values.toList().cast<FirebaseMessage>();

    // Add a listener to watch for changes
    notificationBox!.watch().listen((event) {
      _notificationList = notificationBox!.values.toList().cast<FirebaseMessage>();
      notifyListeners();
    });
  }


  /// Retrieves the notification list.
  List<FirebaseMessage> get notificationList => _notificationList;


  /// Adds a notification to the list and persists it using SharedPreferences.
  Future<void> addNotification(FirebaseMessage value) async {
    await notificationBox!.add(value);
    await resetNotificationList();
    notifyListeners();
  }

  FirebaseMessage getNotification(int index)
  {
      if(notificationList.length != notificationBox!.length)
        logger.w("Not matching");

      return notificationList[index];
  }

  /// Removes a notification from the list at the specified [index] and persists the updated list using SharedPreferences.
  void removeNotification(int index) async {
    _notificationList.removeAt(index);
    notificationBox!.deleteAt(index);
    notifyListeners();
  }

  /// Clears all notifications from the list and persists the updated list using SharedPreferences.
  Future<void> clearNotifications() async {
    await notificationBox!.deleteAll(notificationBox!.keys);
    notificationList.clear();
    notifyListeners();
  }

  Future<void> resetNotificationList() async
  {
    await Hive.close();
    await initHive();
  }

  Future<void> close() async
  {
    if (notificationBox!.isOpen) {
      await notificationBox!.close();
    }
    notificationBox = null;
  }

  /// Returns the count of notifications in the list.
  ///
  /// If the notification list is empty, returns 0.
  int notificationCount() {
    if (_notificationList.isEmpty) return 0;
    return _notificationList.length;
  }
}