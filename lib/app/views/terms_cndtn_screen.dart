import 'package:dropgo/app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DottedContainerScreen extends StatelessWidget {
  const DottedContainerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(
          "Agreement".tr,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Terms and Conditions *".tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            CustomPaint(
              painter: SimpleDottedBorder(),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "1. Engagement and Duties".tr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.lightBackground,
                      ),
                    ),
                    SizedBox(height: 6),
                    BulletPoint(
                      text: "Deliver goods in a safe and professional manner.".tr,
                    ),
                    BulletPoint(text: "Verify orders before delivery.".tr),
                    BulletPoint(text: "Ensure safety during transit.".tr),
                    SizedBox(height: 14),
                    Text(
                      "2. Code of Conduct".tr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.lightBackground,
                      ),
                    ),
                    SizedBox(height: 6),
                    BulletPoint(text: "Maintain professional behavior.".tr),
                    BulletPoint(text: "Avoid disrespectful language.".tr),
                    BulletPoint(text: "Do not tamper with delivery.".tr),
                    SizedBox(height: 14),
                    Text(
                      "3. Personal Responsibility".tr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.lightBackground,
                      ),
                    ),
                    SizedBox(height: 6),
                    BulletPoint(text: "Carry a valid driver’s license.".tr),
                    BulletPoint(text: "Follow all traffic rules.".tr),
                    BulletPoint(text: "No drug/alcohol use during work.".tr),
                    SizedBox(height: 14),
                    Text(
                      "4. Vehicle Maintenance".tr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    BulletPoint(text: "Ensure vehicle is serviced regularly.".tr),
                    BulletPoint(
                      text: "Keep the vehicle clean and well-maintained.".tr,
                    ),
                    BulletPoint(
                      text: "Report any technical issues immediately.".tr,
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

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 14)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

class SimpleDottedBorder extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double dashWidth = 5;
    const double dashSpace = 3;
    final paint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(12),
        ),
      );

    final metrics = path.computeMetrics().toList();
    for (final metric in metrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final extractPath = metric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
