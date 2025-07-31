import 'package:dropgo/app/constants/Api_service.dart';
import 'package:dropgo/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPasswordController extends GetxController {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  RxBool obscure1 = true.obs;
  RxBool obscure2 = true.obs;

  void toggleObscure1() => obscure1.value = !obscure1.value;
  void toggleObscure2() => obscure2.value = !obscure2.value;

  var isLoading = false.obs;

  final DeliveryAuthApis _api = DeliveryAuthApis();

  Future<void> updatePassword(String email) async {
    final password = passwordController.text.trim();
    final confirm = confirmPasswordController.text.trim();

    if (password.isEmpty || confirm.isEmpty) {
      Get.snackbar("Error", "All fields are required");
      return;
    }

    if (password != confirm) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    isLoading.value = true;
    try {
      final success = await _api.updatePassword(
        email: email,
        newPassword: password,
      );

      if (success) {
        Get.snackbar("Success", "Password updated successfully. Please log in again.");
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (e) {
      Get.snackbar("Failed", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}