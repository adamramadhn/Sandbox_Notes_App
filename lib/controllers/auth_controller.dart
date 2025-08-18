import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sandbox_notes_app/screens/home_screen.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  GlobalKey<FormState> formKeySignup = GlobalKey<FormState>();
  GlobalKey<FormState> formKeySignin = GlobalKey<FormState>();
  RxString emailController = "".obs;
  RxString passwordController = "".obs;

  doSignIn() {
    if (emailController.isNotEmpty && passwordController.isNotEmpty) {
      isLoggedIn.value = true;
      Get.replace(() => HomeScreen());
    }
  }
}
