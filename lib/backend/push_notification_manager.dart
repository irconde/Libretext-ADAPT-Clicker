import 'package:shared_preferences/shared_preferences.dart';

/// A class that manages push notifications and persists the notification list using SharedPreferences.
class PushNotificationManager {
  static final PushNotificationManager _instance = PushNotificationManager._internal();
  late SharedPreferences prefs;
  static bool _notificationSet = false;
  static List<String> _notificationList = [];

  factory PushNotificationManager() {
    return _instance;
  }

  PushNotificationManager._internal() {
    initializePersistedState();
  }

  /// Initializes the persisted state by retrieving the notification list from SharedPreferences.
  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _notificationList =
        prefs.getStringList('ff_notificationList') ?? _notificationList;
  }

  /// Retrieves the notification list.
  List<String> get notificationList => _notificationList;

  /// Sets the notification list and persists it using SharedPreferences.
  set notificationList(List<String> value) {
    _notificationList = value;
    prefs.setStringList('ff_notificationList', value);
  }

  //TODO: This is a temp solution, when adding from push notifications is implemented, get rid of this
  /// Gets the status of the notification set.
  bool get notificationSet => _notificationSet;

  //TODO: This is a temp solution, when adding from push notifications is implemented, get rid of this
  /// Sets the status of the notification set and persists it using SharedPreferences.
  set notificationSet(bool value) {
    _notificationSet = value;
    prefs.setBool('ff_notificationSet', value);
  }

  /// Adds a notification to the list and persists it using SharedPreferences.
  void addNotification(String value) {
    //TODO: This is a temp solution, when adding from push notifications is implemented, get rid of this
    _notificationList.add(value);
    prefs.setStringList('ff_notificationList', _notificationList);
  }

  /// Removes a notification from the list at the specified [index] and persists the updated list using SharedPreferences.
  void removeNotification(int index) {
    _notificationList.removeAt(index);
    prefs.setStringList('ff_notificationList', _notificationList);
  }

  /// Clears all notifications from the list and persists the updated list using SharedPreferences.
  void clearNotifications() {
    _notificationList.clear();
    prefs.setStringList('ff_notificationList', _notificationList);
  }

  /// Returns the count of notifications in the list.
  ///
  /// If the notification list is empty, returns 0.
  int notificationCount() {
    if (_notificationList.isEmpty) return 0;
    return _notificationList.length;
  }
}