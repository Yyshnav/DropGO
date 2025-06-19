import 'package:dropgo/app/constants/colors.dart';
import 'package:dropgo/app/routes/app_routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Background Circle
            Positioned(
              top: -size.width * 0.2,
              left: -size.width * 0.6,
              child: Container(
                width: size.width * 1.5,
                height: size.width * 1.5,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFFFFF7EC), Color(0xFF006970)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    ...List.generate(14, (index) {
                      final double top = (index * 30) % (size.width * 1.2);
                      final double left = (index * 80) % (size.width * 1.3);
                      return Positioned(
                        top: top,
                        left: left,
                        child: Container(
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    }),
                    Align(
                      alignment: const Alignment(1.1, 0.0),
                      child: Transform.translate(
                        offset: Offset(0, size.height * 0.02),
                        child: Image.asset(
                          'assets/images/Group (1).png',
                          height: size.height * 0.25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Scrollable Content
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.55,
                  left: 24,
                  right: 24,
                  bottom: 40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Enter your username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      style: const TextStyle(color: Colors.black),
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.forgot);
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Colors.teal[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(value: true, onChanged: (val) {}),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(color: Colors.black),
                              children: [
                                const TextSpan(
                                  text: "By signing up I agree to the ",
                                ),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.toNamed(AppRoutes.terms);
                                    },
                                  text: "Terms of use",
                                  style: TextStyle(color: Colors.teal[800]),
                                ),
                                const TextSpan(text: " and "),
                                TextSpan(
                                  text: "Privacy Policy.",
                                  style: TextStyle(color: Colors.teal[800]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.activebgclr,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Get.offNamed(AppRoutes.home);
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 16),
                        ),
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
