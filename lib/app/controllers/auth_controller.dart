import 'package:dropgo/app/constants/Api_service.dart';
import 'package:dropgo/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryAuthController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isPasswordVisible = false.obs;

  /// ✅ Login Method
  Future<void> login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Error",
        "Username and Password cannot be empty",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;

    final error = await DeliveryAuthApis.login(
      username: username,
      password: password,
    );

    isLoading.value = false;

    if (error == null) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.snackbar(
        "Login Failed",
        error,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[50],
      );
    }
  }

  /// ✅ Toggle Password Visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  /// ✅ Logout Method
  Future<void> logout() async {
    await DeliveryAuthApis.logout();
    Get.offAllNamed('/delivery/login'); // Adjust route as needed
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
