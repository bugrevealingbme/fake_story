import 'package:shared_preferences/shared_preferences.dart';

class CustomSharedPref {
  static Future<void> writeStringDataToSharedPref(
      String key, String data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, data);
  }

  static Future<String?> readStringDataToSharedPref(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString(key);
    print(action);
    return action;
  }

  static Future<String?> readStringDataToLanguage(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString(key);
    print(action);
    return action;
  }
}
