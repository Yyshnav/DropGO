// import 'dart:io';
// import 'package:dropgo/app/constants/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class PostComplaintScreen extends StatefulWidget {
//   @override
//   _PostComplaintScreenState createState() => _PostComplaintScreenState();
// }

// class _PostComplaintScreenState extends State<PostComplaintScreen> {
//   final TextEditingController _descriptionController = TextEditingController();
//   XFile? _selectedImage;

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final image = await picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         _selectedImage = image;
//       });
//     }
//   }

//   void _logComplaint() {
//     debugPrint("Complaint: ${_descriptionController.text}");
//     debugPrint("Image: ${_selectedImage?.path ?? 'No image selected'}");
//   }

//   @override
//   Widget build(BuildContext context) {
//     final charCount = _descriptionController.text.length;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Post complaint"),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//         elevation: 0,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Description",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//             const SizedBox(height: 8),

//             /// Dashed box with text field
//             DashedRect(
//               child: Container(
//                 height: 140,
//                 padding: const EdgeInsets.all(8),
//                 child: TextField(
//                   controller: _descriptionController,
//                   maxLength: 100,
//                   maxLines: null,
//                   onChanged: (_) => setState(() {}),
//                   decoration: const InputDecoration(
//                     border: InputBorder.none,
//                     hintText: 'Enter your complaint...',
//                     counterText: '', // Hide default counter
//                   ),
//                 ),
//               ),
//             ),

//             /// Counter below box aligned left
//             Padding(
//               padding: const EdgeInsets.only(top: 4, left: 4),
//               child: Text(
//                 "$charCount/100",
//                 style: const TextStyle(fontSize: 12, color: Colors.grey),
//               ),
//             ),

//             const SizedBox(height: 20),

//             /// Image picker
//             GestureDetector(
//               onTap: _pickImage,
//               child: DashedRect(
//                 child: Container(
//                   height: 140,
//                   width: double.infinity,
//                   child: _selectedImage == null
//                       ? Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: const [
//                             Icon(
//                               Icons.image,
//                               size: 32,
//                               color: AppColors.primary,
//                             ),
//                             SizedBox(height: 8),
//                             Text(
//                               "Upload Proof (optional)",
//                               style: TextStyle(color: Colors.grey),
//                             ),
//                           ],
//                         )
//                       : Image.file(
//                           File(_selectedImage!.path),
//                           fit: BoxFit.cover,
//                         ),
//                 ),
//               ),
//             ),

//             const Spacer(),

//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _logComplaint,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primary,
//                   foregroundColor: AppColors.activebgclr,

//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                 ),
//                 child: const Text("Post", style: TextStyle(fontSize: 16)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// /// Dashed border painter (no package)
// class DashedRect extends StatelessWidget {
//   final Widget child;
//   final Color color;
//   final double strokeWidth;
//   final double dashWidth;
//   final double gap;
//   final double borderRadius;

//   const DashedRect({
//     required this.child,
//     this.color = Colors.grey,
//     this.strokeWidth = 1.0,
//     this.dashWidth = 6.0,
//     this.gap = 3.0,
//     this.borderRadius = 12.0,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: _DashedBorderPainter(
//         color: color,
//         strokeWidth: strokeWidth,
//         dashWidth: dashWidth,
//         gap: gap,
//         borderRadius: borderRadius,
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(borderRadius),
//         child: child,
//       ),
//     );
//   }
// }

// class _DashedBorderPainter extends CustomPainter {
//   final Color color;
//   final double strokeWidth;
//   final double dashWidth;
//   final double gap;
//   final double borderRadius;

//   _DashedBorderPainter({
//     required this.color,
//     required this.strokeWidth,
//     required this.dashWidth,
//     required this.gap,
//     required this.borderRadius,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color
//       ..strokeWidth = strokeWidth
//       ..style = PaintingStyle.stroke;

//     final rRect = RRect.fromRectAndRadius(
//       Offset.zero & size,
//       Radius.circular(borderRadius),
//     );
//     final path = Path()..addRRect(rRect);
//     final pathMetrics = path.computeMetrics();

//     for (final metric in pathMetrics) {
//       double distance = 0;
//       while (distance < metric.length) {
//         final end = distance + dashWidth;
//         canvas.drawPath(metric.extractPath(distance, end), paint);
//         distance = end + gap;
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
import 'dart:io';
import 'package:dropgo/app/constants/colors.dart';
import 'package:flutter/material.dart';
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
    debugPrint("Complaint: ${_descriptionController.text}");
    debugPrint("Image: ${_selectedImage?.path ?? 'No image selected'}");
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
        title: const Text("Post complaint"),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Description",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.darkText : AppColors.black,
              ),
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
                    hintText: 'Enter your complaint...',
                    hintStyle: TextStyle(
                      color: isDark
                          ? AppColors.darkInactive
                          : AppColors.txtfldclr,
                    ),
                    counterText: '',
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
                              "Upload Proof (optional)",
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

            const Spacer(),

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
                child: const Text("Post", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
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

  const DashedRect({
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
