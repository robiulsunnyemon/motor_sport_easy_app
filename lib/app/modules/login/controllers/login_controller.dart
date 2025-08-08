import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../routes/app_pages.dart';


class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void loginWithEmail() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();


    try {
      final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);



      //update profile
      Get.offAllNamed(Routes.BOTTOM_NAVIGATION_BAR);


    } catch (e) {
      Get.snackbar("Login Failed", e.toString());
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
