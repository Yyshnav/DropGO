import 'package:dropgo/app/constants/colors.dart';
import 'package:dropgo/app/constants/custom_size.dart';
import 'package:dropgo/app/controllers/otp_controller.dart';
import 'package:dropgo/app/routes/app_routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyCodeScreen extends StatelessWidget {
  final String email;
  VerifyCodeScreen({super.key, required this.email});
  
  final List<TextEditingController> codeControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  String getEnteredOTP() {
    return codeControllers.map((c) => c.text).join();
  }

  
  

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OtpController());
    double fieldSize = Responsive.width(context) * 0.13;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(Responsive.width(context) * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Check your email".tr,
              style: TextStyle(
                fontSize: Responsive.width(context) * 0.05,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            Responsive.h(context, 1),
            Text.rich(
              TextSpan(
                text: "We sent a reset link to ".tr,
                style: TextStyle(
                  fontSize: Responsive.width(context) * 0.035,
                  color: Colors.grey[700],
                ),
                children: [
                  TextSpan(
                    text: email,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Responsive.h(context, 1),
            Text(
              "Enter 4 digit code that is mentioned in the email".tr,
              style: TextStyle(
                fontSize: Responsive.width(context) * 0.035,
                color: Colors.grey[600],
              ),
            ),
            Responsive.h(context, 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                4,
                (index) => SizedBox(
                  width: fieldSize,
                  child: TextField(
                    controller: codeControllers[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    style: TextStyle(
                      fontSize: fieldSize * 0.5,
                      color: AppColors.primary,
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty &&
                          index < codeControllers.length - 1) {
                        FocusScope.of(context).nextFocus();
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.primary),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Responsive.h(context, 5),
            SizedBox(
              width: double.infinity,
              height: Responsive.height(context) * 0.065,
              child: ElevatedButton(
                onPressed: controller.isLoading.value
                      ? null
                      : () {
                          final otp = getEnteredOTP();
                          controller.verifyOtp(email, otp);
                        },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.lightBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: 
                controller.isLoading.value
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                  "Verify Code".tr,
                  style: TextStyle(fontSize: Responsive.width(context) * 0.045),
                ),
              ),
            ),
            Responsive.h(context, 2),
            // Center(
            //   child: Text.rich(
            //     TextSpan(
            //       text: "Haven’t got the email yet? ".tr,
            //       style: TextStyle(
            //         fontSize: Responsive.width(context) * 0.035,
            //         color: Colors.grey[700],
            //       ),
            //       children: [
            //         TextSpan(
            //           text: "Resend link".tr,
            //           style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //             color: AppColors.primary,
            //           ),
            //           recognizer: TapGestureRecognizer()
            // ..onTap = () {
            //   // 👇 Call your resend OTP/email function here
            //   controller.resendOtp(email);
            // },
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Obx(() => Center(
  child: controller.timeLeft.value > 0
    ? Text(
        "Resend link in ${controller.formattedTime}",
        style: TextStyle(
          fontSize: Responsive.width(context) * 0.035,
          color: Colors.grey[700],
        ),
      )
    : Text.rich(
        TextSpan(
          text: "Haven’t got the email yet? ".tr,
          style: TextStyle(
            fontSize: Responsive.width(context) * 0.035,
            color: Colors.grey[700],
          ),
          children: [
            TextSpan(
              text: "Resend link".tr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  controller.resendOtp(email);
                },
            ),
          ],
        ),
      ),
))

          ],
        ),
      ),
    );
  }
}
