import 'dart:convert';

import 'package:blavapp/model/user_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsRepo {
  final SharedPreferences _prefsInstance;

  static const String keyLang = 'lang';
  static const String keyTheme = 'theme';
  static const String keyEventFocus = 'event';
  static const String keyUserCurrency = 'userCurrency';
  static const String keyUserNotificationPush = 'userNotificationPush';
  static const String keyUserNotificationProgramme =
      'userNotificationProgramme';
  static const String keyUserNotificationStory = 'userNotificationStory';
  static const String keyUserNotification10 = 'userNotification10';
  static const String keyUserNotification30 = 'userNotification30';
  static const String keyUserNotification60 = 'userNotification60';
  static const String keyUsetDataLocal = 'userDataLocal';

  PrefsRepo(SharedPreferences prefs) : _prefsInstance = prefs;

  String? loadLang() {
    return _prefsInstance.getString(keyLang);
  }

  void saveLang(String? value) {
    _prefsInstance.setString(keyLang, value ?? '');
  }

  String? loadTheme() {
    return _prefsInstance.getString(keyTheme);
  }

  void saveTheme(String? value) {
    _prefsInstance.setString(keyTheme, value ?? '');
  }

  String? loadEvent() {
    return _prefsInstance.getString(keyEventFocus);
  }

  void saveEvent(String? value) {
    _prefsInstance.setString(keyEventFocus, value ?? '');
  }

  String? loadUserCurrency() {
    return _prefsInstance.getString(keyUserCurrency);
  }

  void saveUserCurrency(String? value) {
    _prefsInstance.setString(keyUserCurrency, value ?? '');
  }

  bool? loadUserNotificationPush() {
    return _prefsInstance.getBool(keyUserNotificationPush);
  }

  void saveUserNotificationPush(bool? value) {
    _prefsInstance.setBool(keyUserNotificationPush, value ?? true);
  }

  bool? loadUserNotificationProgramme() {
    return _prefsInstance.getBool(keyUserNotificationProgramme);
  }

  void saveUserNotificationProgramme(bool? value) {
    _prefsInstance.setBool(keyUserNotificationProgramme, value ?? true);
  }

  bool? loadUserNotificationStory() {
    return _prefsInstance.getBool(keyUserNotificationStory);
  }

  void saveUserNotificationStory(bool? value) {
    _prefsInstance.setBool(keyUserNotificationStory, value ?? true);
  }

  bool? loadUserNotification10() {
    return _prefsInstance.getBool(keyUserNotification10);
  }

  void saveUserNotification10(bool? value) {
    _prefsInstance.setBool(keyUserNotification10, value ?? false);
  }

  bool? loadUserNotification30() {
    return _prefsInstance.getBool(keyUserNotification30);
  }

  void saveUserNotification30(bool? value) {
    _prefsInstance.setBool(keyUserNotification30, value ?? false);
  }

  bool? loadUserNotification60() {
    return _prefsInstance.getBool(keyUserNotification60);
  }

  void saveUserNotification60(bool? value) {
    _prefsInstance.setBool(keyUserNotification60, value ?? false);
  }

  UserDataLocal? loadUserDataLocal() {
    final String? data = _prefsInstance.getString(keyUsetDataLocal);
    if (data != null) {
      return UserDataLocal.fromJson(jsonDecode(data));
    }
    return null;
  }

  void saveUserDataLocal(UserDataLocal? value) {
    if (value != null) {
      _prefsInstance.setString(keyUsetDataLocal, jsonEncode(value.toJson()));
    }
  }
}
