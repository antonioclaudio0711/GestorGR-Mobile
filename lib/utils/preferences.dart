import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static Future<bool> getBool(String key) async {
    var preferences = await SharedPreferences.getInstance();
    return preferences.getBool(key) ?? false;
  }

  static void setBool(String key, bool value) async {
    var preferences = await SharedPreferences.getInstance();
    preferences.setBool(key, value);
  }

  static Future<int> getInt(String key) async {
    var preferences = await SharedPreferences.getInstance();
    return preferences.getInt(key) ?? 0;
  }

  static void setInt(String key, int value) async {
    var preferences = await SharedPreferences.getInstance();
    preferences.setInt(key, value);
  }

  static Future<String> getString(String key) async {
    var preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? '';
  }

  static void setString(String key, String value) async {
    var preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }
}
