import 'package:adapt_clicker/utils/timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _rememberMe = prefs.getBool('ff_rememberMe') ?? _rememberMe;
    _authToken = prefs.getString('ff_authToken') ?? _authToken;
    _notificationList =
        prefs.getStringList('ff_notificationList') ?? _notificationList;
  }

  late SharedPreferences prefs;

  bool _rememberMe = false;

  bool get rememberMe => _rememberMe;

  set rememberMe(bool value) {
    _rememberMe = value;
    prefs.setBool('ff_rememberMe', value);
  }

  String _authToken = '';

  String get authToken => _authToken;

  set authToken(String value) {
    _authToken = value;
    prefs.setString('ff_authToken', value);
  }

  static List<String> _notificationList = [];
  List<String> errorsList = [];

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

  static bool _notificationSet = false;

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

  dynamic view;

  bool assignmentUp = false;

  dynamic question;

  bool isBasic = false;

  bool hasSubmission = false;

  static TimezonesContainer? timezoneContainer;

}
