import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper {
  static Future<void> saveUser(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', email);
  }

  static Future<String?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_email');
  }
}
