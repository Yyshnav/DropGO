import 'package:dropgo/app/constants/Api_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ChangePasswordController extends GetxController {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isLoading = false.obs;

  final DeliveryAuthApis _authService = DeliveryAuthApis();

  Future<void> changePassword() async {
    final current = currentPasswordController.text.trim();
    final newPass = newPasswordController.text.trim();
    final confirm = confirmPasswordController.text.trim();

    if (newPass != confirm) {
      Get.snackbar("Error", "New password and confirmation do not match");
      return;
    }

    isLoading.value = true;
    try {
      final response = await _authService.changePassword(
        currentPassword: current,
        newPassword: newPass,
        confirmPassword: confirm,
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Password changed successfully");
        Get.back();
      } else {
        Get.snackbar("Error", response.data['message'] ?? 'Something went wrong');
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to change password");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
