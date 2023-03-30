import 'package:adapt_clicker/utils/timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/lat_lng.dart';

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
    _notificationList = prefs.getStringList('ff_notificationList') ?? _notificationList;
  }

  late SharedPreferences prefs;

  bool _rememberMe = false;

  bool get rememberMe => _rememberMe;

  set rememberMe(bool _value) {
    _rememberMe = _value;
    prefs.setBool('ff_rememberMe', _value);
  }

  String _authToken = '';

  String get authToken => _authToken;

  set authToken(String _value) {
    _authToken = _value;
    prefs.setString('ff_authToken', _value);
  }



  static List<String> _notificationList = [];
  List<String> errorsList = [];

  List<String> get notificationList => _notificationList;

  set notificationList(List<String> _value) {
    _notificationList = _value;
    prefs.setStringList('ff_notificationList', _value);
  }


  //TODO: This is a temp solution, when adding from push notifications is implemented, get rid of this
  bool get notificationSet => _notificationSet;

  set notificationSet(bool _value) {
    _notificationSet = _value;
    prefs.setBool('ff_notificationSet', _value);
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

  void clearNotifications()
  {
    _notificationList.clear();
    prefs.setStringList('ff_notificationList', _notificationList);
  }

  int notificationCount()
  {
    if(_notificationList.isEmpty)
      return 0;

    return _notificationList.length;
  }

  dynamic view;

  bool assignmentUp = false;

  dynamic question;

  bool isBasic = false;

  bool hasSubmission = false;

  static TimezonesContainer? timezoneContainer;



  LatLng? _latLngFromString(String? val) {
    if (val == null) {
      return null;
    }
    final split = val.split(',');
    final lat = double.parse(split.first);
    final lng = double.parse(split.last);
    return LatLng(lat, lng);
  }
}
