import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sandbox_notes_app/screens/home_screen.dart';
import 'package:sandbox_notes_app/storage/user.dart';
import 'package:uuid/uuid.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  GlobalKey<FormState> formKeySignup = GlobalKey<FormState>();
  GlobalKey<FormState> formKeySignin = GlobalKey<FormState>();
  RxString emailController = "".obs;
  RxString passwordController = "".obs;
  RxString fullNameController = "".obs;
  Uuid uuid = const Uuid();

  // doSignIn() {
  //   if (emailController.isNotEmpty && passwordController.isNotEmpty) {
  //     isLoggedIn.value = true;
  //     Get.replace(() => HomeScreen());
  //   }
  // }

  Future register(
    BuildContext context, {
    required String name,
    required String email,
    required String password,
  }) async {
    // Buka box
    var box = await Hive.openBox<User>('user');
    try {
      User data = User(
        id: uuid.v4(),
        name: name,
        email: email,
        password: password,
      );
      // cek apakah data user sudah ada
      final isExisting = box.values.any((user) => user.email == email);
      if (isExisting) {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder:
              (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text('Email already exists'),
                    ),
                  ),
                ],
              ),
        );
        return;
      }

      await box.put(uuid.v4(), data);
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder:
            (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Text('Register Success'),
                  ),
                ),
              ],
            ),
      );
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future signIn() async {
    try {
      var box = await Hive.openBox<User>('user');
      final isExisting = box.values.any(
        (user) =>
            user.email == emailController.value &&
            user.password == passwordController.value,
      );
      if (isExisting) {
        isLoggedIn.value = true;
        Get.replace(() => HomeScreen());
      } else {
        Get.snackbar("Error", "Email or Password is wrong");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  clearLocalStorage() async {
    var box = await Hive.openBox<User>('user');
    box.clear();
  }
}
