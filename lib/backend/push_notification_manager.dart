import 'package:shared_preferences/shared_preferences.dart';

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

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _notificationList =
        prefs.getStringList('ff_notificationList') ?? _notificationList;
  }

  List<String> get notificationList => _notificationList;

  set notificationList(List<String> value) {
    _notificationList = value;
    prefs.setStringList('ff_notificationList', value);
  }

  //TODO: This is a temp solution, when adding from push notifications is implemented, get rid of this
  bool get notificationSet => _notificationSet;

  set notificationSet(bool value) {
    _notificationSet = value;
    prefs.setBool('ff_notificationSet', value);
  }

  void addNotification(String value) {
    //TODO: This is a temp solution, when adding from push notifications is implemented, get rid of this
    _notificationList.add(value);
    prefs.setStringList('ff_notificationList', _notificationList);
  }

  void removeNotification(int index) {
    _notificationList.removeAt(index);
    prefs.setStringList('ff_notificationList', _notificationList);
  }

  void clearNotifications() {
    _notificationList.clear();
    prefs.setStringList('ff_notificationList', _notificationList);
  }

  int notificationCount() {
    if (_notificationList.isEmpty) return 0;
    return _notificationList.length;
  }
}
