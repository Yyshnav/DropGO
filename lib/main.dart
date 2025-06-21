// import 'package:dropgo/app/constants/app_theme.dart';
// import 'package:dropgo/app/constants/translations.dart';
// import 'package:dropgo/app/routes/app_routes.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       translations: AppTranslations(),
//       // locale: const Locale('en', 'US'),

//       locale: Get.deviceLocale ,
//       fallbackLocale: const Locale('en', 'US'),
//       title: 'DropGo',
//       debugShowCheckedModeBanner: false,
//       theme: AppTheme.theme,
//       initialRoute: AppRoutes.onboarding1,
//       getPages: AppRoutes.routes,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dropgo/app/constants/app_theme.dart';
import 'package:dropgo/app/constants/translations.dart';
import 'package:dropgo/app/routes/app_routes.dart';
import 'package:dropgo/app/controllers/theme_controller.dart'; 

void main() async {
  await GetStorage.init(); 
  final themeController = Get.put(ThemeController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final themeController = Get.find<ThemeController>();
      return GetMaterialApp(
        translations: AppTranslations(),
        locale: Get.deviceLocale,
        fallbackLocale: const Locale('en', 'US'),
        title: 'DropGo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.isDarkMode.value
            ? ThemeMode.dark
            : ThemeMode.light,
        initialRoute: AppRoutes.onboarding1,
        getPages: AppRoutes.routes,
      );
    });
  }
}
