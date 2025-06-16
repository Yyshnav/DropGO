import 'package:dropgo/app/views/change_password.dart';
import 'package:dropgo/app/views/editProfile_screen.dart';
import 'package:dropgo/app/views/forgotPassword_screen.dart';
import 'package:dropgo/app/views/login_screen.dart';
import 'package:dropgo/app/views/onboarding1_screen.dart';
import 'package:dropgo/app/views/onboarding2_screen.dart';
import 'package:dropgo/app/views/onboarding3_screen.dart';
import 'package:dropgo/app/views/order_history.dart';
import 'package:dropgo/app/views/order_screen.dart';
import 'package:dropgo/app/views/otp_scren.dart';
import 'package:dropgo/app/views/otp_success_screen.dart';
import 'package:dropgo/app/views/set_new_password.dart';
import 'package:dropgo/app/views/splash_screen.dart';
import 'package:dropgo/app/views/terms_cndtn_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  static const onboarding1 = '/onboarding1';
  static const onboarding2 = '/onboarding2';
  static const onboarding = '/onboarding';
  static const splash = '/splash';
  static const login = '/login';
  static const terms = '/terms';
  static const order = '/order';
  static const editprofile = '/editprofile';
  static const changepass = '/changepass';
  static const NewPassword = '/NewPasswordScreen';
  static const otp = '/otp';
  static const forgotpass = '/forgotpass';
  static const otpsuccess = '/otpsuccess';
  static const orderhistory = '/orderhistory';

  static final routes = [
    GetPage(name: onboarding1, page: () => IntroScreen()),
    GetPage(name: onboarding2, page: () => IntroScreen2()),
    GetPage(name: onboarding, page: () => OnboardingScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: terms, page: () => DottedContainerScreen()),
    GetPage(name: order, page: () => OrderScreen()),
    GetPage(name: editprofile, page: () => EditProfilescreen()),
    GetPage(name: changepass, page: () => ChangePasswordScreen()),
    GetPage(name: NewPassword, page: () => NewPasswordScreen()),
    GetPage(name: otp, page: () => VerifyCodeScreen()),
    GetPage(name: forgotpass, page: () => ForgotPasswordScreen()),
    GetPage(name: otpsuccess, page: () => PasswordChangedSuccessScreen()),
    GetPage(name: orderhistory, page: () => OrderHistoryScreen()),
  ];
}
