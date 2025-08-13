import 'package:dropgo/app/constants/Api_constants.dart';
import 'package:dropgo/app/constants/Api_service.dart';
import 'package:dropgo/app/constants/token_interceptor.dart';
import 'package:dropgo/app/controllers/deliveryorder_controller.dart';
import 'package:dropgo/app/controllers/network_controller.dart';
import 'package:dropgo/app/views/network_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dropgo/app/constants/app_theme.dart';
import 'package:dropgo/app/constants/translations.dart';
import 'package:dropgo/app/routes/app_routes.dart';
import 'package:dropgo/app/controllers/theme_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// Local notification setup
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Background FCM handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("🔔 Background message: ${message.notification?.title}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  // ApiConstants.init();

  final authApi = DeliveryAuthApis();
  authApi.setupInterceptors();
  Get.put(ThemeController());
  Get.put(NetworkController());
  Get.put(DeliveryAuthApis());
  // Get.put(LocationController(), permanent: true);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
    // Background FCM message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Local notifications (Android)
  const initializationSettingsAndroid = AndroidInitializationSettings(
    '@mipmap/ic_launcher',
  );

  const initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Android 8+ notification channel
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.high,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final NetworkController networkController = Get.find();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      final bool isDark = themeController.isDarkMode.value;
      if (!networkController.hasInternet.value) {
        return MaterialApp(
          home: NoInternetPage(
            onRetry: networkController.retryConnection,
            isDark: isDark,
          ),
        );
      } 
      return GetMaterialApp(
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
        );
      }
    );
  }
}
