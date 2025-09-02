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
        await _getAndSendFCMToken(email);
        Get.offAllNamed(Routes.BOTTOM_NAVIGATION_BAR);
      }
    } catch (e) {
      Get.snackbar("Login Failed", e.toString());
    }
  }

  Future<void> _getAndSendFCMToken(String email) async {
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

      // Send token to your backend API
      await _sendTokenToBackend(token, email);
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

}