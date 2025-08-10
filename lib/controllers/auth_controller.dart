import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  doSignIn() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      isLoggedIn.value = true;
    }
  }
}
