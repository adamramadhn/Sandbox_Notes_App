import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandbox_notes_app/controllers/auth_controller.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: authController.formKeySignup,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Register', style: TextTheme.of(context).headlineLarge),
                SizedBox(height: 8),
                Text(
                  'And start taking notes',
                  style: TextTheme.of(
                    context,
                  ).bodyMedium?.copyWith(color: Colors.grey),
                ),
                SizedBox(height: 24),
                Text('Full Name', style: TextTheme.of(context).labelMedium),
                SizedBox(height: 8),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Example: Adam Ramadhan",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Text('Email Address', style: TextTheme.of(context).labelMedium),
                SizedBox(height: 8),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Example: adam@gmail.com",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Text('Password', style: TextTheme.of(context).labelMedium),
                SizedBox(height: 8),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "**********",
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
                ),
                GestureDetector(
                  onTap: () {
                    authController.formKeySignup.currentState?.save();
                    if (authController.formKeySignup.currentState!.validate()) {
                      authController.doSignIn();
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
                        "Register",
                        style: TextTheme.of(context).labelMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: Text(
                    "Already have an account? Login here",
                    style: TextTheme.of(
                      context,
                    ).bodyMedium?.copyWith(color: Color(0xff394675)),
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
