import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandbox_notes_app/controllers/auth_controller.dart';
import 'package:sandbox_notes_app/screens/home_screen.dart';
import 'package:sandbox_notes_app/screens/signin_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Obx(
        () => authController.isLoggedIn.value ? HomeScreen() : SigninScreen(),
      ),
    );
  }
}
