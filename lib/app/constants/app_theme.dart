import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTheme {
  static final theme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    primaryColor: AppColors.Primary,
    colorScheme: ColorScheme.light(
      primary: AppColors.Primary,
      secondary: AppColors.lightSecondary,
    ),
    textTheme: GoogleFonts.outfitTextTheme().apply(
      bodyColor: AppColors.white,
      displayColor: AppColors.white,
    ),
    fontFamily: GoogleFonts.outfit().fontFamily,
  );
}
