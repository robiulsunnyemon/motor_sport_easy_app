import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_sport_easy/app/modules/widgets/custom_elevated_button.dart';

class ForgotPasswordDialog extends StatelessWidget {
  ForgotPasswordDialog({super.key,});


  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text("Reset Password"),
      content: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: "Enter your email"),
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
        SizedBox(
          width: 150,
          child: CustomElevatedButton(
            onTap: () async {

              try {
                await FirebaseAuth.instance
                    .sendPasswordResetEmail(email: emailController.text.trim());
                Get.snackbar("Success", "Password reset link sent to your email");
              } catch (e) {
                Get.snackbar("Error", e.toString());
              }


            },

            level: "Send Reset Link",

          ),
        ),
      ],
    );
  }
}
