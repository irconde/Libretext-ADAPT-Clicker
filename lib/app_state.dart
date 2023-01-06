import 'package:adapt_clicker/timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/lat_lng.dart';
import 'dart:convert';

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
    _selectedIndex = prefs.getInt('ff_selectedIndex') ?? _selectedIndex;
  }

  late SharedPreferences prefs;

  bool _rememberMe = false;

  bool get rememberMe => _rememberMe;

  set rememberMe(bool _value) {
    _rememberMe = _value;
    prefs.setBool('ff_rememberMe', _value);
  }


  //Selected index for questions
  int _selectedIndex = 1;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int _value) {
    _selectedIndex = _value;
    prefs.setInt('ff_selectedIndex', _value);
  }

  String _authToken = '';

  String get authToken => _authToken;

  set authToken(String _value) {
    _authToken = _value;
    prefs.setString('ff_authToken', _value);
  }

  List<String> errorsList = [];

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
