import 'dart:math';
import 'package:dropgo/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class IntroScreen2 extends StatelessWidget {
  const IntroScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    final double width = screen.width;
    final double height = screen.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient and dots
          Positioned(
            top: -height * 0.15,
            left: -width * 0.35,
            child: Stack(
              children: [
                // Abstract background shape (responsive)
                Container(
                  height: height * 0.9,
                  width: width * 1.4,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment(0.0, 1.1),
                      end: Alignment.topCenter,
                      colors: [Color(0xFFFFF7EC), Color(0xFF006970)],
                    ),
                  ),
                ),

                // Dots over background
                ..._buildWhiteDots(width, height),
              ],
            ),
          ),

          // Main content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.05),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                  child: Text(
                    "${'Deliver Food'.tr}\n${'Fast,'.tr}\n${'Earn Even'.tr}\n${'Faster!'.tr}",
                    style: TextStyle(
                      fontSize: width * 0.085,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                SizedBox(height: height * 0.03),

                Center(
                  child: Image.asset(
                    'assets/images/Group 7.png',
                    height: height * 0.30,
                  ),
                ),

                SizedBox(height: height * 0.2),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: index == 1 ? 24 : 12,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: index == 1 ? Colors.black : Colors.black26,
                      ),
                    );
                  }),
                ),

                Spacer(),
                // Next button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF006970),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: height * 0.018),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Get.toNamed(AppRoutes.onboarding);
                    },
                    child: Center(
                      child: Text(
                        "Next".tr,
                        style: TextStyle(fontSize: width * 0.04),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.04),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Responsive white dot generator
  List<Widget> _buildWhiteDots(double width, double height) {
    final random = Random();
    return List.generate(15, (index) {
      final double top = random.nextDouble() * height * 0.6;
      final double left = random.nextDouble() * width * 1.2;

      return Positioned(
        top: top,
        left: left,
        child: Container(
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            shape: BoxShape.circle,
          ),
        ),
      );
    });
  }
}
