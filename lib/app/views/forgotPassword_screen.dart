import 'package:dropgo/app/constants/colors.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Forgot password",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.Primary,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Please enter your email to reset the password",
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 30),
            Text(
              "Your Email",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.Primary,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Enter your email",
                hintStyle: TextStyle(color: AppColors.txtfldclr),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.Primary, width: 1.5),
                ),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.Primary,
                  foregroundColor: AppColors.lightBackground,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("Reset Password"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
