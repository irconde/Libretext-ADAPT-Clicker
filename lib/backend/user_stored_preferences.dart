import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';

/// A class that provides access to stored user preferences using SharedPreferences.
class UserStoredPreferences {
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

  /// Initializes the SharedPreferences instance and returns it.
  ///
  /// This method should be called from the `initState()` function of the main App.
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance!;
  }

  /// Retrieves a string value associated with the given [key].
  ///
  /// If the value is not found, [defValue] is returned.
  static String getString(String key, [String? defValue]) {
    return _prefsInstance!.getString(key) ?? defValue ?? '';
  }

  /// Retrieves a boolean value associated with the given [key].
  ///
  /// If the value is not found, `false` is returned.
  static bool getBool(String key) {
    return _prefsInstance!.getBool(key) ?? false;
  }

  /// Retrieves an integer value associated with the given [key].
  ///
  /// If the value is not found, `1` is returned.
  static int getInt(String key) {
    return _prefsInstance!.getInt(key) ?? 1;
  }

  /// Retrieves the value of 'rememberMe' key.
  ///
  /// If the value is not found, `false` is returned.
  static bool get rememberMe => getBool(_keyRememberMe);


  /// Retrieves the value of 'authToken' key.
  ///
  /// If the value is not found, an empty string is returned.
  static String get authToken => getString(_keyAuthToken);

  /// Retrieves the value of 'deviceIDToken' key.
  ///
  /// If the value is not found, an empty string is returned.
  static String get deviceIDToken => getString(_deviceIDToken);

  /// Retrieves the value of 'userAccount' key.
  ///
  /// If the value is not found, an empty string is returned.
  static String get userAccount => getString(_keyUserAccount);

  /// Retrieves the value of 'userPassword' key.
  ///
  /// If the value is not found, an empty string is returned.
  static String get userPassword => getString(_keyUserPassword);

  /// Retrieves the value of 'selectedIndex' key.
  ///
  /// If the value is not found, `1` is returned.
  static int get selectedIndex => getInt(_keySelectedIndex);

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key, value);
  }

  /// Sets the string [value] associated with the given [key].
  ///
  /// Returns `true` if the value is successfully set, `false` otherwise.
  static Future<bool> setBool(String key, bool value) async {
    var prefs = await _instance;
    return prefs.setBool(key, value);
  }

  /// Sets the integer [value] associated with the given [key].
  ///
  /// Returns `true` if the value is successfully set, `false` otherwise.
  static Future<bool> setInt(String key, int value) async {
    var prefs = await _instance;
    return prefs.setInt(key, value);
  }

  /// Sets the value of 'rememberMe' key to the specified [value].
  static set rememberMe(bool value) {
    setBool(_keyRememberMe, value);
  }

  /// Sets the value of 'authToken' key to the specified [value].
  static set authToken(String value) {
    setString(_keyAuthToken, value);
  }

  /// Sets the value of 'deviceIDToken' key to the specified [value].
  static set deviceIDToken(String value) {
    setString(_deviceIDToken, value);
  }

  /// Sets the value of 'userAccount' key to the specified [value].
  static set userAccount(String value) {
    setString(_keyUserAccount, value);
  }

  /// Sets the value of 'userPassword' key to the specified [value].
  static set userPassword(String value) {
    setString(_keyUserPassword, value);
  }

  /// Sets the value of 'selectedIndex' key to the specified [value].
  static set selectedIndex(int value) {
    setInt(_keySelectedIndex, value);
  }
}
