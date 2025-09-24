import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferences? _prefs;

  // Initialize shared preferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save string value
  static Future<bool> setString(String key, String value) async {
    if (_prefs == null) await init();
    return await _prefs!.setString(key, value);
  }

  // Get string value
  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  // Save boolean value
  static Future<bool> setBool(String key, bool value) async {
    if (_prefs == null) await init();
    return await _prefs!.setBool(key, value);
  }

  // Get boolean value
  static bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  // Remove value
  static Future<bool> remove(String key) async {
    if (_prefs == null) await init();
    return await _prefs!.remove(key);
  }

  // Clear all values
  static Future<bool> clear() async {
    if (_prefs == null) await init();
    return await _prefs!.clear();
  }
}
