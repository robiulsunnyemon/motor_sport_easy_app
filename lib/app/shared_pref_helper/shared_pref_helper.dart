import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static const String _uidKey = 'uid';

  static Future<void> saveUid(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_uidKey, uid);
  }

  static Future<String?> getUid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_uidKey);
  }

  static Future<void> clearUid() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_uidKey);
  }
}