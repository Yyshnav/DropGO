import 'package:dropgo/app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  List<Widget> _buildWhiteDots() {
    final random = Random();
    return List.generate(10, (index) {
      final double top = random.nextDouble() * 600;
      final double left = random.nextDouble() * 350;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Color(0xFFFFF7EC), Color(0xFF006970)],
              ),
            ),
          ),

          // White decorative dots
          ..._buildWhiteDots(),

          // Large second image with indicator at center
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/Background_Complete.png',
                  height: 140,
                  fit: BoxFit.contain,
                ),
                Positioned(
                  bottom: 30,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.,
                    children: List.generate(3, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: index == 0 ? 24 : 12,
                        height: 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: index == 0 ? Colors.black : Colors.white54,
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),

          // Foreground UI
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 50),
                RichText(
                  // textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Set to GO,\n",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text:
                            "         Ready to flow", // 4 spaces before "Ready"
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Image.asset('assets/images/Motocycle.png', height: 300),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.lightBackground,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // Get.toNamed('/next');
                    },
                    child: Center(
                      child: Text("Next", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
