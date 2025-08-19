import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:motor_sport_easy/app/routes/app_pages.dart';

class LoginDashboardController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var obscureText = true.obs;

  void changeObscureText() {
    obscureText.value = !obscureText.value;
    refresh();
  }

  void login({required BuildContext context}) {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {

      if(email=="stewartbrown195111@gmail.com" && password=="stewartbrown195111"){
        Get.offAndToNamed(Routes.RACE_ADMIN);
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Logged in as $email')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
    }
  }
}
