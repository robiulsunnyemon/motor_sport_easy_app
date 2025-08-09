import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:motor_sport_easy/app/shared_pref_helper/shared_pref_helper.dart';

import '../../../routes/app_pages.dart';


class LoginController extends GetxController {
  final emailController = TextEditingController(text: "heahimu@gmail.com");
  final passwordController = TextEditingController(text: "123456");
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void loginWithEmail() async {


    final email = emailController.text.trim();
    final password = passwordController.text.trim();


    try {
      final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);

      SharedPrefHelper.saveUid(userCredential.user!.uid);
      String? uid=await SharedPrefHelper.getUid();
      if(uid!=null){
          Get.offAllNamed(Routes.BOTTOM_NAVIGATION_BAR);
      }

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
