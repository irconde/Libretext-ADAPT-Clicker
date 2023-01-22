import 'package:adapt_clicker/timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState {
  static final FFAppState _instance = FFAppState._internal();
  static const _keyRememberMe = 'ff_rememberMe';
  static const _keyAuthToken = 'ff_authToken';
  static const _keySelectedIndex = 'ff_selectedIndex';

  SharedPreferences? prefs;

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _rememberMe = prefs!.getBool(_keyRememberMe) ?? _rememberMe;
    _authToken = prefs!.getString(_keyAuthToken) ?? _authToken;
    _selectedIndex = prefs!.getInt(_keySelectedIndex) ?? _selectedIndex;
  }

  bool _rememberMe = false;

  bool get rememberMe => _rememberMe;

  set rememberMe(bool _value) {
    _rememberMe = _value;
    prefs?.setBool(_keyRememberMe, _value);
  }

  //Selected index for questions
  int _selectedIndex = 1;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int _value) {
    _selectedIndex = _value;
    prefs?.setInt(_keySelectedIndex, _value);
  }

  String _authToken = '';

  String get authToken => _authToken;

  set authToken(String _value) {
    _authToken = _value;
    prefs?.setString(_keyAuthToken, _value);
  }

  List<String> errorsList = [];

  dynamic view;

  bool assignmentUp = false;

  dynamic question;

  bool isBasic = false;

  bool hasSubmission = false;

  static TimezonesContainer? timezoneContainer;
}
