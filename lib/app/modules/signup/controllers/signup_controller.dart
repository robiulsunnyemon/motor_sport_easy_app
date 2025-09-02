import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../routes/app_pages.dart';

class SignupController extends GetxController {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signUpWithEmail() async {

    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final fullName=fullNameController.text.trim();

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      Get.snackbar("Success", "Account created for $email");

      User? user = userCredential.user;

      if (user != null) {
        await user.updateDisplayName(fullName);
        await user.reload();
        Get.offAllNamed(Routes.LOGIN);
      }

    } catch (e) {
      Get.snackbar("Signup Failed", e.toString());
    }
  }

}
