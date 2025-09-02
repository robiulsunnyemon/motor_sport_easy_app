import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_sport_easy/app/modules/widgets/custom_elevated_button.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';
import '../widgets/forget_password_dialog.dart';

class LoginView extends GetView<LoginController> {
   LoginView({super.key});
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 30),

                // Email
                buildInputField(
                  label: 'Email',
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    } else if (!GetUtils.isEmail(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password
                buildInputField(
                  label: 'Password',
                  controller: controller.passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Get.dialog(
                        ForgotPasswordDialog(),
                      );
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Color(0xFFDC2626),
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                // Login Button
                CustomElevatedButton(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      controller.loginWithEmail();
                    }
                  },
                  level: "Login",
                ),

                const SizedBox(height: 16),

                // 🔹 Don't have an account? Signup
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(fontFamily: 'Inter'),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.SIGNUP); // 🔁 SIGNUP রাউটে পাঠাবে
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFDC2626),
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(labelText: label, border: InputBorder.none),
      ),
    );
  }
}
