import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  var showLanguageOptions = false.obs;

  final languages = [
    {'name': 'English', 'locale': const Locale('en', 'US')},
    {'name': 'മലയാളം', 'locale': const Locale('ml', 'IN')},
    {'name': 'العربية', 'locale': const Locale('ar', 'SA')},
    {'name': 'हिंदी', 'locale': const Locale('hi', 'IN')},
  ];  

  void toggleLanguageOptions() {
    showLanguageOptions.value = !showLanguageOptions.value;
  }

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    showLanguageOptions.value = false;
  }
}
