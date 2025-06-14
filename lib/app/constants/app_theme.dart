import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTheme {
  static final theme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.lightSecondary,
    ),
    textTheme: GoogleFonts.outfitTextTheme().apply(
      bodyColor: Colors.black,
      displayColor: Colors.black,
    ),
    fontFamily: GoogleFonts.poppins().fontFamily,
  );
}
