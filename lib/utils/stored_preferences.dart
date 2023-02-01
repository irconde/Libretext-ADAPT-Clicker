import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';

class StoredPreferences {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  // Key values
  static const _keyRememberMe = 'ff_rememberMe';
  static const _keyAuthToken = 'ff_authToken';
  static const _deviceIDToken = 'ff_deviceIDToken';
  static const _keyUserAccount = 'ff_userAccount';
  static const _keyUserPassword = 'ff_userPassword';
  static const _keySelectedIndex = 'ff_selectedIndex';

  // Call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance!;
  }

  static String getString(String key, [String? defValue]) {
    return _prefsInstance!.getString(key) ?? defValue ?? "";
  }

  static bool getBool(String key) {
    return _prefsInstance!.getBool(key) ?? false;
  }

  static int getInt(String key) {
    return _prefsInstance!.getInt(key) ?? 1;
  }

  static bool get rememberMe => getBool(_keyRememberMe);
  static String get authToken => getString(_keyAuthToken);
  static String get deviceIDToken => getString(_deviceIDToken);
  static String get userAccount => getString(_keyUserAccount);
  static String get userPassword => getString(_keyUserPassword);
  static int get selectedIndex => getInt(_keySelectedIndex);

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key, value);
  }

  static Future<bool> setBool(String key, bool value) async {
    var prefs = await _instance;
    return prefs.setBool(key, value);
  }

  static Future<bool> setInt(String key, int value) async {
    var prefs = await _instance;
    return prefs.setInt(key, value);
  }

  static set rememberMe(bool value) {
    setBool(_keyRememberMe, value);
  }

  static set authToken(String value) {
    setString(_keyAuthToken, value);
  }
  static set deviceIDToken(String value) {
    setString(_deviceIDToken, value);
  }


  static set userAccount(String value) {
    setString(_keyUserAccount, value);
  }

  static set userPassword(String value) {
    setString(_keyUserPassword, value);
  }

  static set selectedIndex(int value) {
    setInt(_keySelectedIndex, value);
  }
}
