import 'package:hive/hive.dart';
import 'package:adapt_clicker/utils/firebase_message.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import '../utils/firebase_message_adapter.dart';

/// A class that manages push notifications and persists the notification list using SharedPreferences.
class PushNotificationManager {

  static PushNotificationManager? _instance;
  Box? notificationBox;
  static List<FirebaseMessage> _notificationList = [];
  bool _initialized = false;

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
    notificationBox = await Hive.openBox<FirebaseMessage>('notificationBox');
    _notificationList =  notificationBox!.values.toList().cast<FirebaseMessage>();
  }

  Future<void> initHive() async
  {
// Initialize Hive
    final appDocumentsDirectory = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentsDirectory.path);

    if(!_initialized) {
      Hive.registerAdapter(
          FirebaseMessageAdapter()); // Make sure to register the adapter
      _initialized = true;
    }
    await Hive.openBox<FirebaseMessage>('notificationBox');
  }


  /// Retrieves the notification list.
  List<FirebaseMessage> get notificationList => _notificationList;

  /// Sets the notification list and persists it using SharedPreferences.
  set notificationList(List<FirebaseMessage> value) {
    _notificationList = value;
    notificationBox!.clear();
    notificationBox!.addAll(value);
  }

  /// Adds a notification to the list and persists it using SharedPreferences.
  void addNotification(FirebaseMessage value) async {
    _notificationList.add(value);
    notificationBox!.add(value);
    await resetNotificationList();
  }

  FirebaseMessage getNotification(int index)
  {
      return notificationBox!.getAt(index);
  }

  /// Removes a notification from the list at the specified [index] and persists the updated list using SharedPreferences.
  void removeNotification(int index) async {
    _notificationList.removeAt(index);
    notificationBox!.deleteAt(index);
    await resetNotificationList();
  }

  /// Clears all notifications from the list and persists the updated list using SharedPreferences.
  void clearNotifications() {
    _notificationList.clear();
    notificationBox!.clear();
  }

  Future<void> resetNotificationList() async
  {
    notificationBox = await Hive.openBox<FirebaseMessage>('notificationBox');
    _notificationList =  notificationBox!.values.toList().cast<FirebaseMessage>();
  }

  /// Returns the count of notifications in the list.
  ///
  /// If the notification list is empty, returns 0.
  int notificationCount() {
    if (_notificationList.isEmpty) return 0;
    return _notificationList.length;
  }
}