import 'package:dropgo/app/constants/colors.dart';
import 'package:dropgo/app/constants/custom_size.dart';
import 'package:dropgo/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/success.png', height: 135, width: 135),
            const SizedBox(height: 20), 
            SizedBox(width: 300,
              child: Text('Your last order was delivered smoothly!',textAlign: TextAlign.center,
                  style: TextStyle(
                        letterSpacing: 0.5,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 24
                      )),
            ),
            Responsive.h(context, 2),
            SizedBox(width: 310,
              child: const Text('Ready for your next delivery? Head back to the app and keep the orders coming!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 16,
                  )),
            ),
            Responsive.h(context, 3),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 12),
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24),side: BorderSide(color: AppColors.primary)),
              
              ),
              
              onPressed: (){
                Get.toNamed(AppRoutes.home);
              }, child: Text('Get Orders',style: GoogleFonts.outfit(fontSize: 17, fontWeight: FontWeight.bold),))
          ],
        ),
      ),
    );
  }
}