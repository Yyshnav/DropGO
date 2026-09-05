
import 'dart:io';
import 'package:dropgo/app/constants/colors.dart';
import 'package:dropgo/app/constants/custom_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PostComplaintScreen extends StatefulWidget {
  @override
  _PostComplaintScreenState createState() => _PostComplaintScreenState();
}

class _PostComplaintScreenState extends State<PostComplaintScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  XFile? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  void _logComplaint() {
    debugPrint("${'Complaint'.tr}: ${_descriptionController.text}");
    debugPrint("${'Image'.tr}: ${_selectedImage?.path ?? 'No image selected'.tr}");
    Navigator.pop(context);
    Get.snackbar("Success".tr, "Complaint sent successfully".tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(0, 0, 104, 112),
        colorText: AppColors.white);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final charCount = _descriptionController.text.length;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      appBar: AppBar(
        title: Text("Post complaint".tr),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? AppColors.white : AppColors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: isDark
            ? AppColors.darkBackground
            : AppColors.lightBackground,
        foregroundColor: isDark ? AppColors.white : AppColors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
             
              Text(
                "Description".tr,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: isDark ? AppColors.darkText : AppColors.black,),
              ),
              const SizedBox(height: 8),
          
              // Dashed TextField
              DashedRect(
                color: isDark ? AppColors.darkInactive : Colors.grey,
                child: Container(
                  height: 140,
                  padding: const EdgeInsets.all(8),
                  color: isDark
                      ? AppColors.darkCardBg
                      : AppColors.lightBackground,
                  child: TextField(
                    controller: _descriptionController,
                    maxLength: 100,
                    maxLines: null,
                    style: TextStyle(
                      color: isDark ? AppColors.darkText : AppColors.black,
                    ),
                    onChanged: (_) => setState(() {}),
                    
                    decoration: InputDecoration(
                      border: InputBorder.none,
                     
                      hintStyle: TextStyle(
                        color: isDark
                            ? AppColors.darkInactive
                            : AppColors.txtfldclr,
                      ),
                      counterText: '',
                      hintText: 'Enter your complaint...'.tr,
                      
                    ),
                  ),
                ),
              ),
          
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 4),
                child: Text(
                  "$charCount/100",
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppColors.darkInactive : Colors.grey.shade600,
                  ),
                ),
              ),
          
              const SizedBox(height: 20),
          
              // Image Picker
              GestureDetector(
                onTap: _pickImage,
                child: DashedRect(
                  color: isDark ? AppColors.darkInactive : Colors.grey,
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    color: isDark
                        ? AppColors.darkCardBg
                        : AppColors.lightBackground,
                    child: _selectedImage == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            
                              Icon(
                                Icons.image,
                                size: 32,
                                color: AppColors.primary,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Upload Proof (optional)".tr,
                                style: TextStyle(
                                  color: isDark
                                      ? AppColors.darkInactive
                                      : Colors.grey,
                                ),
                                
                              ),
                            ],
                          )
                        : Image.file(
                            File(_selectedImage!.path),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
          
              Responsive.h(context, 30),
          
              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _logComplaint,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.lightBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text("Post".tr, style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// DashedRect with custom painter
class DashedRect extends StatelessWidget {
  final Widget child;
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double gap;
  final double borderRadius;

  DashedRect({
    required this.child,
    this.color = Colors.grey,
    this.strokeWidth = 1.0,
    this.dashWidth = 6.0,
    this.gap = 3.0,
    this.borderRadius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(
        color: color,
        strokeWidth: strokeWidth,
        dashWidth: dashWidth,
        gap: gap,
        borderRadius: borderRadius,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: child,
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double gap;
  final double borderRadius;

  _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.gap,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rRect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(borderRadius),
    );
    final path = Path()..addRRect(rRect);
    final pathMetrics = path.computeMetrics();

    for (final metric in pathMetrics) {
      double distance = 0;
      while (distance < metric.length) {
        final end = distance + dashWidth;
        canvas.drawPath(metric.extractPath(distance, end), paint);
        distance = end + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
