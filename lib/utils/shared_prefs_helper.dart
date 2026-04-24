// lib/utils/helpers/shared_prefs_helper.dart
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static SharedPreferences? _prefs;

  /// Initialize once (e.g., in main.dart)
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Set a string
  static Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  /// Get a string
  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  /// Set int
  static Future<void> setInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  /// Get int
  static int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  /// Remove a key
  static Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  /// Clear all
  static Future<void> clear() async {
    await _prefs?.clear();
  }

  /// Debug: print all keys and values
  static void debugLogAll() {
    if (_prefs != null) {
      print("---- SharedPreferences Data ----");
      for (var key in _prefs!.getKeys()) {
        print("$key: ${_prefs!.get(key)}");
      }
      print("--------------------------------");
    } else {
      print("⚠️ SharedPreferences not initialized yet!");
    }
  }
}
