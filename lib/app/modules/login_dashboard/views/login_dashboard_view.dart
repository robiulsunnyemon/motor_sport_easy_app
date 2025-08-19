import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_dashboard_controller.dart';

class LoginDashboardView extends GetView<LoginDashboardController> {
  const LoginDashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: screenWidth > 600
            ? Center(
                child: SizedBox(
                  width: 600,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 40),
                      TextField(
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          fillColor: Colors.white70,
                          filled: true,
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Obx(
                        () => TextField(
                          controller: controller.passwordController,
                          obscureText: controller.obscureText.value,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            fillColor: Colors.white70,
                            filled: true,
                            border: const OutlineInputBorder(),
                            enabledBorder: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.obscureText.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                controller.changeObscureText();
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          controller.login(context: context);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                        ),
                        child: const Text('Login'),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          // Forgot password action
                        },
                        child: const Text('Forgot Password?'),
                      ),
                    ],
                  ),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      fillColor: Colors.white70,
                      filled: true,
                      border: OutlineInputBorder(),
                      enabledBorder:  OutlineInputBorder(),
                      focusedBorder:  OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => TextField(
                      controller: controller.passwordController,
                      obscureText: controller.obscureText.value,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        fillColor: Colors.white70,
                        filled: true,
                        border: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.obscureText.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            controller.changeObscureText();
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      controller.login(context: context);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      // Forgot password action
                    },
                    child: const Text('Forgot Password?'),
                  ),
                ],
              ),
      ),
    );
  }
}
