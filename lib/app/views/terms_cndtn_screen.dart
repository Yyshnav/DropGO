import 'package:dropgo/app/constants/colors.dart';
import 'package:flutter/material.dart';

class DottedContainerScreen extends StatelessWidget {
  const DottedContainerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Primary,
      appBar: AppBar(
        backgroundColor: AppColors.Primary,
        elevation: 0,
        title: const Text(
          "Agreement",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Terms and Conditions *",
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "1. Engagement and Duties",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.lightBackground,
                      ),
                    ),
                    SizedBox(height: 6),
                    BulletPoint(
                      text: "Deliver goods in a safe and professional manner.",
                    ),
                    BulletPoint(text: "Verify orders before delivery."),
                    BulletPoint(text: "Ensure safety during transit."),
                    SizedBox(height: 14),
                    Text(
                      "2. Code of Conduct",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.lightBackground,
                      ),
                    ),
                    SizedBox(height: 6),
                    BulletPoint(text: "Maintain professional behavior."),
                    BulletPoint(text: "Avoid disrespectful language."),
                    BulletPoint(text: "Do not tamper with delivery."),
                    SizedBox(height: 14),
                    Text(
                      "3. Personal Responsibility",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.lightBackground,
                      ),
                    ),
                    SizedBox(height: 6),
                    BulletPoint(text: "Carry a valid driver’s license."),
                    BulletPoint(text: "Follow all traffic rules."),
                    BulletPoint(text: "No drug/alcohol use during work."),
                    SizedBox(height: 14),
                    Text(
                      "4. Vehicle Maintenance",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    BulletPoint(text: "Ensure vehicle is serviced regularly."),
                    BulletPoint(
                      text: "Keep the vehicle clean and well-maintained.",
                    ),
                    BulletPoint(
                      text: "Report any technical issues immediately.",
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
