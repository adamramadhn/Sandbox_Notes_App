import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sandbox_notes_app/controllers/auth_controller.dart';
import 'package:sandbox_notes_app/screens/home_screen.dart';
import 'package:sandbox_notes_app/screens/signin_screen.dart';
import 'package:sandbox_notes_app/storage/note_item_model.dart';
import 'package:sandbox_notes_app/storage/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(NoteItemModelAdapter());
  await Hive.openBox('settings');
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
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        textTheme: TextTheme(
          labelSmall: TextStyle(
            fontFamily: "Inter",
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          labelMedium: TextStyle(
            fontFamily: "Inter",
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          labelLarge: TextStyle(
            fontFamily: "Inter",
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          titleSmall: TextStyle(
            fontFamily: "Inter",
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          titleMedium: TextStyle(
            fontFamily: "Inter",
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          titleLarge: TextStyle(
            fontFamily: "Inter",
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          bodySmall: TextStyle(
            fontFamily: "Inter",
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: TextStyle(
            fontFamily: "Inter",
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          bodyLarge: TextStyle(
            fontFamily: "Inter",
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          headlineSmall: TextStyle(
            fontFamily: "Inter",
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          headlineMedium: TextStyle(
            fontFamily: "Inter",
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          headlineLarge: TextStyle(
            fontFamily: "Inter",
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Obx(
        () => authController.isLoggedIn.value ? HomeScreen() : SigninScreen(),
      ),
    );
  }
}
