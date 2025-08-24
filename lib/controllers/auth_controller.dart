import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sandbox_notes_app/screens/home_screen.dart';
import 'package:sandbox_notes_app/screens/signin_screen.dart';
import 'package:sandbox_notes_app/storage/user_model.dart';
import 'package:uuid/uuid.dart';

class AuthController extends GetxController {
  GlobalKey<FormState> formKeySignup = GlobalKey<FormState>();
  GlobalKey<FormState> formKeySignin = GlobalKey<FormState>();
  RxString emailController = "".obs;
  RxString passwordController = "".obs;
  RxString fullNameController = "".obs;
  Uuid uuid = const Uuid();
  final _isLoggedIn = false.obs;
  late Box _settingsBox;
  RxBool isHide = true.obs;

  RxBool get isLoggedIn => _isLoggedIn;

  @override
  void onInit() {
    super.onInit();
    // Buka box yang sudah dibuat di main()
    _settingsBox = Hive.box('settings');
    // Muat status login dari Hive
    _isLoggedIn.value = _settingsBox.get('isLoggedIn', defaultValue: false);
  }

  void logout() async {
    await _settingsBox.put('isLoggedIn', false);
    _isLoggedIn.value = false;
    Get.offAll(() => SigninScreen());
  }

  Future register(
    BuildContext context, {
    required String name,
    required String email,
    required String password,
  }) async {
    // Buka box
    var box = await Hive.openBox<UserModel>('user');
    try {
      UserModel data = UserModel(
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
      var box = await Hive.openBox<UserModel>('user');
      final isExisting = box.values.any(
        (user) =>
            user.email == emailController.value &&
            user.password == passwordController.value,
      );
      if (isExisting) {
        await _settingsBox.put('isLoggedIn', true);
        _isLoggedIn.value = true;
        Get.replace(() => HomeScreen());
      } else {
        Get.snackbar("Error", "Email or Password is wrong");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
