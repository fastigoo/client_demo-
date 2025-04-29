import 'dart:convert';

import 'package:learning/core/resources/storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static StorageManager? _instance;

  StorageManager._();

  static StorageManager get instance {
    _instance ??=
        StorageManager._(); // If _instance is null, create a new instance
    return _instance!;
  }

  static SharedPreferences? prefs;
  static Future initStorage() async {
    prefs = await SharedPreferences.getInstance();
  }

  // remove all data
  void clearAllData() {
    prefs?.clear();
  }

  void removeKey({required String key}) {
    prefs?.remove(key);
  }

  // setData

  Future<void> saveToken({required String token}) {
    return prefs!.setString(StorageKey.tokenKey, token);
  }

  Future<void> saveFcmToken({required String token}) {
    return prefs!.setString(StorageKey.fcmTokenKey, token);
  }

  Future<void> setString({required String key, required String value}) async {
    await prefs!.setString(key, value);
  }

  Future<void> setBool({required String key, required bool value}) async {
    await prefs!.setBool(key, value);
  }

  Future<void> setDouble({required String key, required double value}) async {
    await prefs!.setDouble(key, value);
  }

  Future<void> setInt({required String key, required int value}) async {
    await prefs!.setInt(key, value);
  }

  Future<void> setObject({required String key, required dynamic obj}) async {
    String objString = jsonEncode(obj);
    await prefs!.setString(key, objString);
  }

  // get Data
  String? getToken() {
    return prefs?.getString(StorageKey.tokenKey);
  }

  String? getFcmToken() {
    return prefs?.getString(StorageKey.fcmTokenKey);
  }

  String? getStringValue({required String key}) => prefs?.getString(key) ?? '';
  bool getBoolValue({required String key}) => prefs?.getBool(key) ?? false;
  double getDoubleValue({required String key}) => prefs?.getDouble(key) ?? 0.0;
  int getIntValue({required String key}) => prefs?.getInt(key) ?? 0;
  dynamic getObjectValue<T extends Object?>({required String key}) {
    String? obj = getStringValue(key: key);
    return jsonDecode(obj!);
  }
}
