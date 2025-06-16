import 'package:dropgo/app/views/change_password.dart';
import 'package:dropgo/app/views/editProfile_screen.dart';
import 'package:dropgo/app/views/forgotPassword_screen.dart';
import 'package:dropgo/app/views/login_screen.dart';
import 'package:dropgo/app/views/delivery_order.dart';
import 'package:dropgo/app/views/onboarding1_screen.dart';
import 'package:dropgo/app/views/onboarding2_screen.dart';
import 'package:dropgo/app/views/onboarding3_screen.dart';
import 'package:dropgo/app/views/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  static const onboarding1 = '/onboarding1';
  static const onboarding2 = '/onboarding2';
  static const onboarding = '/onboarding';
  static const splash = '/splash';

  static final routes = [
    GetPage(name: onboarding1, page: () => IntroScreen()),
    GetPage(name: onboarding2, page: () => IntroScreen2()),
    GetPage(name: onboarding, page: () => OnboardingScreen()),
  ];
}
