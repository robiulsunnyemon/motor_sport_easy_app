import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:motor_sport_easy/app/shared_pref_helper/shared_pref_helper.dart';
import '../../../routes/app_pages.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void loginWithEmail() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // Save UID to shared preferences
      SharedPrefHelper.saveUid(userCredential.user!.uid);
      String? uid = await SharedPrefHelper.getUid();

      if (uid != null) {
        // Get FCM token and send to backend
        await _getAndSendFCMToken(email,uid);
      }
    } catch (e) {
      Get.snackbar("Login Failed", e.toString());
    }
  }

  Future<void> _getAndSendFCMToken(String email,String uid) async {
    try {
      // Request notification permissions (important for iOS)
      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      // Get the FCM token
      String? token = await _firebaseMessaging.getToken();

      if (token == null) {
        print("Error: FCM Token is null");
        return;
      }

      print("FCM Token: $token");


      await _sendFCMTokenToFastAPI(token, uid);
    } catch (e) {
      print("Error in FCM token handling: $e");
    }
  }

  Future<void> _sendTokenToBackend(String token, String email) async {
    const String apiUrl = "https://motogp.mtscorporate.com/api/users/register";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fcm_token': token,
          'email': email,
        }),
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        print("FCM Token successfully sent to backend!");

      } else {
        print("Failed to send token: ${response.body}");
      }
    } catch (e) {
      print("Error sending token to backend: $e");
    }
  }





  Future<void> _sendFCMTokenToFastAPI(String token, String uid) async {
    const String apiUrl = "https://motorgp-render.onrender.com/user/registration";
    print("fcm token: $token");
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "uid": uid,
          "fcmToken": token
        }),
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 201) {
        print("FCM Token successfully sent to backend!");
        Get.snackbar("Login Success", "FCM Token successfully sent to backend!");
        final decodedResponse=jsonDecode(response.body);
        print("decoded token: ${decodedResponse["access_token"]}");
        await SharedPrefHelper.saveToken(decodedResponse["access_token"]);
        Get.offAllNamed(Routes.BOTTOM_NAVIGATION_BAR);

      } else {
        Get.snackbar("Login Failed", "Failed to send token: ${response.body}");
        print("Failed to send token: ${response.body}");
      }
    } catch (e) {
      Get.snackbar("Login Failed", "Error sending token to backend: $e");
      print("Error sending token to backend: $e");
    }
  }



}