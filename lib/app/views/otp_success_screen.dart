import 'package:dropgo/app/constants/custom_size.dart';
import 'package:dropgo/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:dropgo/app/constants/colors.dart';
import 'package:get/get.dart';

class PasswordChangedSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = Responsive.width(context);
    double screenHeight = Responsive.height(context);

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.verified,
                color: AppColors.primary,
                size: screenWidth * 0.15,
              ),
              Responsive.h(context, 2),
              Text(
                "Successful".tr,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.05,
                  color: AppColors.primary,
                ),
              ),
              Responsive.h(context, 1.5),
              Text(
                "Congratulations! Your password has been changed. Click continue to login".tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: Colors.grey[600],
                ),
              ),
              Responsive.h(context, 5),
              SizedBox(
                width: double.infinity,
                height: screenHeight * 0.065,
                child: ElevatedButton(
                  onPressed: () {
                    Get.offNamed(AppRoutes.login);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.lightBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Login".tr,
                    style: TextStyle(fontSize: screenWidth * 0.045),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
