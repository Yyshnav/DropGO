import 'dart:io';
import 'package:dropgo/app/constants/Api_service.dart';
import 'package:dropgo/app/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  var isLoading = false.obs;

  Future<void> updateProfile(
    String name,
    String email,
    String phone, {
    File? imageFile, // ✅ optional image
  }) async {
    isLoading.value = true;

    final result = await DeliveryAuthApis.updateProfile(
      name: name,
      email: email,
      phone: phone,
      imageFile: imageFile, // ✅ passed here
    );

    isLoading.value = false;

    if (result == null) {
      // ✅ Also update locally
      Get.find<ProfileController>().updateUser(
        name: name,
        email: email,
        phone: phone,
        image: imageFile?.path, // optional local update
      );

      Get.defaultDialog(
        title: 'Success',
        middleText: 'Profile updated successfully!',
        confirm: ElevatedButton(
          onPressed: () {
            Get.back(); // close dialog
  Get.back(result: true); // return true to trigger reload
          },
          child: const Text("OK"),
        ),
      );
    } else {
      Get.snackbar("Error", result);
    }
  }
}
