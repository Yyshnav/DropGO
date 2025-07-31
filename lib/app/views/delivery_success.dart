
import 'package:dropgo/app/constants/colors.dart';
import 'package:dropgo/app/constants/custom_size.dart';
import 'package:dropgo/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  double customerRating = 0.0;
  final TextEditingController feedbackController = TextEditingController();
  bool showFeedbackField = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : Colors.black87;
    final subTextColor = isDark ? AppColors.darkInactive : Colors.black45;
    final dividerColor = isDark ? Colors.white30 : Colors.grey;
    final cardColor = isDark ? AppColors.darkCardBg : AppColors.cardbgclr;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                Image.asset(
                  'assets/images/success.png',
                  height: 135,
                  width: 135,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: Text(
                    'Your last order was delivered smoothly!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      letterSpacing: 0.5,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                Responsive.h(context, 2),
                SizedBox(
                  width: 310,
                  child: Text(
                    'Ready for your next delivery? Head back to the app and keep the orders coming!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: subTextColor, fontSize: 16),
                  ),
                ),
                Responsive.h(context, 3),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 70,
                      vertical: 12,
                    ),
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: BorderSide(color: AppColors.primary),
                    ),
                  ),
                  onPressed: () {
                    Get.toNamed(AppRoutes.home);
                  },
                  child: Text(
                    'Get Orders',
                    style: GoogleFonts.outfit(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: DashedDivider(height: 1, color: dividerColor),
                ),
                const SizedBox(height: 10),

                const Center(
                  child: Text(
                    "Rate Your Customer 👈",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        index < customerRating ? Icons.star : Icons.star_border,
                        color: Colors.orange.shade400,
                      ),
                      onPressed: () {
                        setState(() {
                          customerRating = index + 1.0;
                          showFeedbackField = (customerRating == 1);
                          if (!showFeedbackField) {
                            feedbackController.clear();
                          }
                        });
                      },
                    );
                  }),
                ),

                if (customerRating == 1 && showFeedbackField) ...[
                  const SizedBox(height: 10),
                  TextField(
                    controller: feedbackController,
                    maxLines: 3,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      hintText: "Tell us what went wrong...",
                      hintStyle: TextStyle(color: subTextColor),
                      filled: true,
                      fillColor: cardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: dividerColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          showFeedbackField = false;
                          feedbackController.clear();
                        });
                      },
                      child: const Text("Close Feedback"),
                    ),
                  ),
                ],

                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (customerRating == 0.0) {
                      Get.snackbar("Rating Missing", "Please provide a rating");
                      return;
                    }

                    print("Rating: $customerRating");
                    print("Feedback: ${feedbackController.text}");

                    Get.snackbar(
                      "Feedback Submitted",
                      "Thanks for rating the customer!",
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.lightBackground,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Submit Feedback"),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DashedDivider extends StatelessWidget {
  final double height;
  final Color color;

  const DashedDivider({super.key, this.height = 1, this.color = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedLinePainter(color: color, height: height),
      child: SizedBox(height: height),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final double height;
  final Color color;
  final double dashWidth = 6;
  final double dashSpace = 4;

  _DashedLinePainter({required this.color, required this.height});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = height;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
