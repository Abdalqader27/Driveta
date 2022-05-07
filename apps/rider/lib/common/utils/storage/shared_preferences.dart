import 'package:shared_preferences/shared_preferences.dart';

enum ValueType { integer, string, double, bool }

class SharedPreferencesHandler {
  static Future setSharedPreference({String? key, var value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is String) await prefs.setString(key!, value);
    if (value is bool) await prefs.setBool(key!, value);
    if (value is double) await prefs.setDouble(key!, value);
    if (value is int) await prefs.setInt(key!, value);
  }

  static Future getSharedPreference<T>(String key, ValueType type) async {
    final sPrefs = await SharedPreferences.getInstance();
    if (type == ValueType.string) return sPrefs.getString(key);
    if (type == ValueType.bool) return sPrefs.getBool(key) ?? false;
    if (type == ValueType.double) return sPrefs.getDouble(key) ?? 0.0;
    if (type == ValueType.integer) return sPrefs.getInt(key) ?? 0;
  }

  static remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static clearShared() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
