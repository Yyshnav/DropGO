import 'package:dropgo/app/views/chat_screen.dart';
import 'package:dropgo/app/views/delivery_order.dart';
import 'package:dropgo/app/views/delivery_success.dart';
import 'package:dropgo/app/views/help_center.dart';
import 'package:dropgo/app/views/onboarding1_screen.dart';
import 'package:dropgo/app/views/onboarding2_screen.dart';
import 'package:dropgo/app/views/onboarding3_screen.dart';
import 'package:dropgo/app/views/order_details.dart';
import 'package:dropgo/app/views/report_emergency.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  static const onboarding1 = '/onboarding1';
  static const onboarding2 = '/onboarding2';
  static const onboarding = '/onboarding';
  static const splash = '/splash';
  static const deliveryorder = '/deliveryorder';
  static const orderdetails = '/orderdetails';
  static const success = '/success';
  static const helpcenter = '/helpcenter';
  static const chat = '/chat';
  static const reportemergency = '/reportemergency';

  static final routes = [
    GetPage(name: onboarding1, page: () => IntroScreen()),
    GetPage(name: onboarding2, page: () => IntroScreen2()),
    GetPage(name: onboarding, page: () => OnboardingScreen()),
    GetPage(name: deliveryorder, page: () => DropScreen()),
    GetPage(name: orderdetails, page: () => OrderDetailsPage(),),
    GetPage(name: success, page: () => SuccessScreen()),
    GetPage(name: helpcenter, page: () => HelpCenterPage()),
    GetPage(name: chat, page: () => ChatScreen()),
    GetPage(name: reportemergency, page: () => ReportEmergencyScreen()),
  ];
}
