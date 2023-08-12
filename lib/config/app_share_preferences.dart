import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static const String keepLoggedIn = 'keepLoggedIn';
  static const String userRole = 'userRole';

  static Future<bool> getKeepLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keepLoggedIn) ?? false;
  }

  static Future<void> setKeepLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keepLoggedIn, value);
  }

  static Future<String?> getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userRole);
  }

  static Future<void> setUserRole(String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(userRole, role);
  }
}
