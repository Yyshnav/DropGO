import 'package:dropgo/app/constants/colors.dart';
import 'package:dropgo/app/constants/custom_size.dart';
import 'package:flutter/material.dart';

class VerifyCodeScreen extends StatelessWidget {
  final List<TextEditingController> codeControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  @override
  Widget build(BuildContext context) {
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
              "Check your email",
              style: TextStyle(
                fontSize: Responsive.width(context) * 0.05,
                fontWeight: FontWeight.bold,
                color: AppColors.Primary,
              ),
            ),
            Responsive.h(context, 1),
            Text.rich(
              TextSpan(
                text: "We sent a reset link to ",
                style: TextStyle(
                  fontSize: Responsive.width(context) * 0.035,
                  color: Colors.grey[700],
                ),
                children: [
                  TextSpan(
                    text: "vaishnav@gmail.com",
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
              "Enter 4 digit code that is mentioned in the email",
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
                      color: AppColors.Primary,
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
                        borderSide: BorderSide(color: AppColors.Primary),
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
                onPressed: () {
                  // TODO: Submit code logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.Primary,
                  foregroundColor: AppColors.lightBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Verify Code",
                  style: TextStyle(
                    fontSize: Responsive.width(context) * 0.045,
                  ),
                ),
              ),
            ),
            Responsive.h(context, 2),
            Center(
              child: Text.rich(
                TextSpan(
                  text: "Haven’t got the email yet? ",
                  style: TextStyle(
                    fontSize: Responsive.width(context) * 0.035,
                    color: Colors.grey[700],
                  ),
                  children: [
                    TextSpan(
                      text: "Resend link",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.Primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
