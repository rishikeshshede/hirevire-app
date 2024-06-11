import 'package:flutter/material.dart';
import 'package:hirevire_app/utils/log_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersistenceHandler {
  static SharedPreferences? _sharedPreferences;

  PersistenceHandler();

  static Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    debugPrint('Initialized SharedPreferences');
  }

  static printValues(String key, dynamic value) {
    debugPrint("Set $key: $value");
  }

  // ------------- SET values -------------

  static void setString(String key, String value) async {
    await init();
    await _sharedPreferences?.setString(key, value);
    printValues(key, value);
  }

  static void setBool(String key, bool value) async {
    await init();
    await _sharedPreferences?.setBool(key, value);
    printValues(key, value);
  }

  static void setInt(String key, int value) async {
    await init();
    await _sharedPreferences?.setInt(key, value);
    printValues(key, value);
  }

  // ------------- GET values -------------

  static Future<dynamic> getString(String key) async {
    await init();
    String? value = _sharedPreferences?.getString(key);
    logData(key, value);
    return value;
  }

  static Future<dynamic> getBool(String key) async {
    await init();
    bool? value = _sharedPreferences?.getBool(key);
    logData(key, value);
    return value;
  }

  static Future<dynamic> getInt(String key) async {
    await init();
    int? value = _sharedPreferences?.getInt(key);
    logData(key, value);
    return value;
  }

  // ------------- DELETE values -------------

  static Future<void> deletePair(String keyToDelete) async {
    await init();
    Set<String>? keys = _sharedPreferences?.getKeys();

    if (keys != null) {
      for (var key in keys) {
        if (key == keyToDelete) {
          await _sharedPreferences?.remove(key);
        }
      }
    }
  }

  static deleteAll() async {
    await init();
    return await _sharedPreferences?.clear();
  }

  static void logData(String key, dynamic value) {
    LogHandler.debug("$key: $value");
  }
}
