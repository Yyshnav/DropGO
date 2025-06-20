import 'package:dropgo/app/views/chat_screen.dart';
import 'package:dropgo/app/views/change_password.dart';
import 'package:dropgo/app/views/editProfile_screen.dart';
import 'package:dropgo/app/views/feedback_screen.dart';
import 'package:dropgo/app/views/forgotPassword_screen.dart';
import 'package:dropgo/app/views/lodingindicator.dart';
import 'package:dropgo/app/views/login_screen.dart';
import 'package:dropgo/app/views/delivery_order.dart';
import 'package:dropgo/app/views/delivery_success.dart';
import 'package:dropgo/app/views/help_center.dart';
import 'package:dropgo/app/views/my_account.dart';
import 'package:dropgo/app/views/my_account.dart';
import 'package:dropgo/app/views/onboarding1_screen.dart';
import 'package:dropgo/app/views/onboarding2_screen.dart';
import 'package:dropgo/app/views/onboarding3_screen.dart';
import 'package:dropgo/app/views/order_details.dart';
import 'package:dropgo/app/views/order_history.dart';
import 'package:dropgo/app/views/order_screen.dart';
import 'package:dropgo/app/views/otp_scren.dart';
import 'package:dropgo/app/views/otp_success_screen.dart';
import 'package:dropgo/app/views/splash_screen.dart';
import 'package:dropgo/app/views/report_emergency.dart';
import 'package:dropgo/app/views/terms_cndtn_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  static const onboarding1 = '/onboarding1';
  static const onboarding2 = '/onboarding2';
  static const onboarding = '/onboarding';
  static const splash = '/splash';
  static const login = '/login';
  static const forgot = '/forgot';
  static const otp = '/otp';
  static const otpsuceess = '/otpsuceess';
  static const success = '/success';
  static const terms = '/terms';
  static const home = '/home';
  static const myaccount = '/myaccount';
  static const help = '/helpcenter';
  static const chat = '/chat';
  static const reportemergency = '/reportemergency';
  static const orderdetails = '/orderdetails';
  static const editprofile = '/editprofile';
  static const orderhistory = '/orderhistory';
  static const account = '/account';
  static const orderscreen = '/orderscreen';
  static const changepwd = '/changepwd';

  static final routes = [
    GetPage(name: onboarding1, page: () => IntroScreen()),
    GetPage(name: onboarding2, page: () => IntroScreen2()),
    GetPage(name: onboarding, page: () => OnboardingScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: forgot, page: () => ForgotPasswordScreen()),
    GetPage(name: otp, page: () => VerifyCodeScreen()),
    GetPage(name: otpsuceess, page: () => PasswordChangedSuccessScreen()),
    GetPage(name: terms, page: () => DottedContainerScreen()),
    GetPage(name: home, page: () => DropScreen()),
    GetPage(name: myaccount, page: () => MyAccountScreen()),
    GetPage(name: orderdetails, page: () => OrderDetailsPage()),
    GetPage(name: success, page: () => SuccessScreen()),
    GetPage(name: editprofile, page: () => EditProfilescreen()),
    GetPage(name: orderhistory, page: () => OrderHistoryScreen()),
    GetPage(name: help, page: () => HelpCenterPage()),
    GetPage(name: chat, page: () => ChatScreen()),
    GetPage(name: reportemergency, page: () => ReportEmergencyScreen()),
    GetPage(name: account, page: () => MyAccountScreen()),
    GetPage(name: orderscreen, page: () => OrderScreen()),
    GetPage(name: changepwd, page: () => ChangePasswordScreen()),
  ];
}
