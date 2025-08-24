import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandbox_notes_app/controllers/auth_controller.dart';
import 'package:sandbox_notes_app/screens/signup_screen.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: authController.formKeySignin,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Lets\'Login', style: TextTheme.of(context).headlineLarge),
                SizedBox(height: 8),
                Text(
                  'And notes your idea',
                  style: TextTheme.of(
                    context,
                  ).bodyMedium?.copyWith(color: Colors.grey),
                ),
                SizedBox(height: 24),
                Text('Email Address', style: TextTheme.of(context).labelMedium),
                SizedBox(height: 8),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    authController.emailController.value = newValue ?? '';
                  },
                ),
                SizedBox(height: 16),
                Text('Password', style: TextTheme.of(context).labelMedium),
                SizedBox(height: 8),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    authController.passwordController.value = newValue ?? '';
                  },
                  obscureText: true,
                  obscuringCharacter: '*',
                ),
                GestureDetector(
                  onTap: () {
                    if (authController.formKeySignin.currentState!.validate()) {
                      authController.formKeySignin.currentState!.save();
                      authController.signIn();
                    }
                  },
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      color: Color(0xff394675),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(top: 24),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextTheme.of(context).labelMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const SignupScreen());
                  },
                  child: Center(
                    child: Text(
                      "Don't have any account? Register here",
                      style: TextTheme.of(
                        context,
                      ).bodyMedium?.copyWith(color: Color(0xff394675)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
