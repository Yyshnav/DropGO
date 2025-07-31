import 'package:dropgo/app/constants/colors.dart';
import 'package:dropgo/app/constants/custom_size.dart';
import 'package:dropgo/app/controllers/newpassword_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class NewPasswordScreen extends StatelessWidget {
  final String email;
  NewPasswordScreen({required this.email});

  final controller = Get.put(NewPasswordController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.width(context) * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Responsive.h(context, 2),
            Text(
              "Set a new password".tr,
              style: TextStyle(
                fontSize: Responsive.width(context) * 0.05,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                letterSpacing: 1.2,
              ),
            ),
            Responsive.h(context, 1),
            Text.rich(
              TextSpan(
                text: "Create a new password. ".tr,
                style: TextStyle(
                  fontSize: Responsive.width(context) * 0.035,
                  color: Colors.grey[700],
                ),
                children: [
                  TextSpan(
                    text: "Ensure it differs from previous ones for security.".tr,
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
            Responsive.h(context, 4),
            Obx(() => TextField(
              controller: controller.passwordController,
              obscureText: controller.obscure1.value,
              style: TextStyle(color: AppColors.black),
              decoration: InputDecoration(
                labelText: "Password".tr,
                labelStyle: TextStyle(
                  fontSize: Responsive.width(context) * 0.04,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.obscure1.value ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.txtfldclr,
                  ),
                  onPressed: () => controller.toggleObscure1,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            )),
            Responsive.h(context, 2.5),
            Obx(() =>TextField(
              controller: controller.confirmPasswordController,
              obscureText: controller.obscure2.value,
              decoration: InputDecoration(
                labelText: "Confirm Password".tr,
                labelStyle: TextStyle(
                  fontSize: Responsive.width(context) * 0.04,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.obscure2.value ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.txtfldclr,
                  ),
                  onPressed: () => controller.toggleObscure2,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            )),
            Responsive.h(context, 5),
            SizedBox(
              width: double.infinity,
              height: Responsive.height(context) * 0.065,
              child: ElevatedButton(
                onPressed: () => controller.updatePassword(email),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.lightBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Update Password".tr,
                  style: TextStyle(fontSize: Responsive.width(context) * 0.045),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
