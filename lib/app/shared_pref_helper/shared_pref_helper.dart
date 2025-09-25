import 'dart:convert';
import 'dart:ffi';

import 'package:get/get.dart';
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
    await clearToken();
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

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

  }



  static Future<void> saveNotification({required int raceId,required int hour})async{
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('$raceId$hour', "active");
  }

  static Future<bool> getNotification({required int raceId,required int hour})async{
    final prefs = await SharedPreferences.getInstance();
    final notificationValue= prefs.getString('$raceId$hour');
    if(notificationValue=="active"){
      return true;
    }else{
      return false;
    }
  }

  static Future<void> clearNotification({required int raceId,required int hour})async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$raceId$hour');
  }







}