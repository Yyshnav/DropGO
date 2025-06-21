// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'colors.dart';

// class AppTheme {
//   static final theme = ThemeData(
//     brightness: Brightness.light,
//     scaffoldBackgroundColor: AppColors.lightBackground,
//     primaryColor: AppColors.primary,
//     colorScheme: ColorScheme.light(
//       primary: AppColors.primary,
//       secondary: AppColors.lightSecondary,
//     ),
//     textTheme: GoogleFonts.outfitTextTheme().apply(
//       bodyColor: Colors.black,
//       displayColor: Colors.black,
//     ),
//     fontFamily: GoogleFonts.outfit().fontFamily,
//   );
// }



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
      bodyColor: AppColors.black,
      displayColor: AppColors.black,
    ),
    cardColor: AppColors.cardbgclr,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.txtfldclr.withOpacity(0.1),
    ),
    fontFamily: GoogleFonts.outfit().fontFamily,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.darkSecondary,
    ),
    textTheme: GoogleFonts.outfitTextTheme().apply(
      bodyColor: AppColors.darkText,
      displayColor: AppColors.darkText,
    ),
    cardColor: AppColors.darkCardBg,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.darkInactive.withOpacity(0.2),
    ),
    fontFamily: GoogleFonts.outfit().fontFamily,
  );
}
