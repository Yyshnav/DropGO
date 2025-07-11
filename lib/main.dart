import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dropgo/app/constants/app_theme.dart';
import 'package:dropgo/app/constants/translations.dart';
import 'package:dropgo/app/routes/app_routes.dart';
import 'package:dropgo/app/controllers/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // Register the controller just once
  Get.put(ThemeController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() => GetMaterialApp(
          title: 'DropGo',
          debugShowCheckedModeBanner: false,
          translations: AppTranslations(),
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('en', 'US'),
          theme: AppTheme.theme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeController.isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light,
          initialRoute: AppRoutes.splash,
          getPages: AppRoutes.routes,
        ));
  }
}
