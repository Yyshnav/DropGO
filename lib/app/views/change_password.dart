// import 'package:dropgo/app/constants/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ChangePasswordScreen extends StatelessWidget {
//   final TextEditingController currentPasswordController =
//       TextEditingController();
//   final TextEditingController newPasswordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final width = size.width;
//     final height = size.height;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: width * 0.06),
//           child: Container(
//             padding: EdgeInsets.all(width * 0.05),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(15),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.2),
//                   blurRadius: 10,
//                   spreadRadius: 2,
//                   offset: const Offset(0, 5),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Text(
//                     "Change Password".tr,
//                     style: TextStyle(
//                       fontSize: width * 0.05,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.primary,
//                       letterSpacing: 1.2,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: height * 0.03),
//                 buildPasswordField(
//                   label: 'Current Password'.tr,
//                   controller: currentPasswordController,
//                   hint: 'Enter your current password'.tr,
//                   width: width,
//                 ),
//                 SizedBox(height: height * 0.02),
//                 buildPasswordField(
//                   label: 'New Password'.tr,
//                   controller: newPasswordController,
//                   hint: 'New password'.tr,
//                   width: width,
//                 ),
//                 SizedBox(height: height * 0.02),
//                 buildPasswordField(
//                   label: 'Confirm Password'.tr,
//                   controller: confirmPasswordController,
//                   hint: 'Confirm password'.tr,
//                   width: width,
//                 ),
//                 SizedBox(height: height * 0.04),
//                 SizedBox(
//                   width: double.infinity,
//                   height: height * 0.06,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Handle save
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.primary,
//                       foregroundColor: AppColors.lightBackground,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                     ),
//                     child: Text(
//                       'SAVE'.tr,
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: width * 0.04,
//                         letterSpacing: 1.2,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildPasswordField({
//     required String label,
//     required TextEditingController controller,
//     required String hint,
//     required double width,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text.rich(
//           TextSpan(
//             text: label,
//             style: TextStyle(
//               fontSize: width * 0.037,
//               fontWeight: FontWeight.w600,
//               color: AppColors.primary,
//             ),
//             children: const [
//               TextSpan(
//                 text: ' *',
//                 style: TextStyle(color: Colors.red),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 6),
//         TextField(
//           controller: controller,
//           obscureText: true,
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: TextStyle(fontSize: width * 0.035),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(6),
//               borderSide: const BorderSide(color: AppColors.primary),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(6),
//               borderSide: const BorderSide(
//                 color: AppColors.primary,
//                 width: 2.5,
//               ),
//             ),
//             contentPadding: EdgeInsets.symmetric(
//               horizontal: width * 0.035,
//               vertical: width * 0.04,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:dropgo/app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: width * 0.06),
          child: Container(
            padding: EdgeInsets.all(width * 0.05),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Change Password".tr,
                    style: TextStyle(
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.03),
                buildPasswordField(
                  context: context,
                  label: 'Current Password'.tr,
                  controller: currentPasswordController,
                  hint: 'Enter your current password'.tr,
                  width: width,
                ),
                SizedBox(height: height * 0.02),
                buildPasswordField(
                  context: context,
                  label: 'New Password'.tr,
                  controller: newPasswordController,
                  hint: 'New password'.tr,
                  width: width,
                ),
                SizedBox(height: height * 0.02),
                buildPasswordField(
                  context: context,
                  label: 'Confirm Password'.tr,
                  controller: confirmPasswordController,
                  hint: 'Confirm password'.tr,
                  width: width,
                ),
                SizedBox(height: height * 0.04),
                SizedBox(
                  width: double.infinity,
                  height: height * 0.06,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle save
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Theme.of(
                        context,
                      ).scaffoldBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      'SAVE'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.04,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPasswordField({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    required String hint,
    required double width,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: label,
            style: TextStyle(
              fontSize: width * 0.037,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
            children: const [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: true,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: width * 0.035,
              color: Theme.of(context).hintColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: AppColors.primary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 2.5,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: width * 0.035,
              vertical: width * 0.04,
            ),
          ),
        ),
      ],
    );
  }
}
