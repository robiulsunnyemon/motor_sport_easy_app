import 'dart:convert';

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

  static Future<void> saveNotificationState(String raceId, Map<String, bool> state) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('notif_$raceId', json.encode(state));
  }

  static Future<Map<String, bool>> getNotificationState(String raceId) async {
    final prefs = await SharedPreferences.getInstance();
    final stateString = prefs.getString('notif_$raceId');
    if (stateString != null) {
      final stateMap = json.decode(stateString) as Map<String, dynamic>;
      return {
        '8hour': stateMap['8hour'] ?? false,
        '3hour': stateMap['3hour'] ?? false,
        '6hour': stateMap['6hour'] ?? false,
      };
    }
    return {'8hour': false, '3hour': false, '6hour': false};
  }
}