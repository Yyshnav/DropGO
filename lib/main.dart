// import 'package:dropgo/app/constants/Api_constants.dart';
// import 'package:dropgo/app/constants/Api_service.dart';
// import 'package:dropgo/app/constants/token_interceptor.dart';
// import 'package:dropgo/app/controllers/deliveryorder_controller.dart';
// import 'package:dropgo/app/controllers/network_controller.dart';
// import 'package:dropgo/app/views/network_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:dropgo/app/constants/app_theme.dart';
// import 'package:dropgo/app/constants/translations.dart';
// import 'package:dropgo/app/routes/app_routes.dart';
// import 'package:dropgo/app/controllers/theme_controller.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// // Local notification setup
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// // Background FCM handler
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   // print("🔔 Background message: ${message.notification?.title}");
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await GetStorage.init();
//   // ApiConstants.init();

//   final authApi = DeliveryAuthApis();
//   authApi.setupInterceptors();
//   Get.put(ThemeController());
//   Get.put(NetworkController());
//   Get.put(DeliveryAuthApis());
//   // Get.put(LocationController(), permanent: true);
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
// );

//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//   NotificationSettings settings = await messaging.requestPermission(
//     alert: true,
//     badge: true,
//     sound: true,
//   );

//   // print('🔔 User granted permission: ${settings.authorizationStatus}');
//     // Background FCM message handler
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//   // Local notifications (Android)
//   const initializationSettingsAndroid = AndroidInitializationSettings(
//     '@mipmap/ic_launcher',
//   );

//   const initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//   );

//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);

//   // Android 8+ notification channel
//   const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel',
//     'High Importance Notifications',
//     importance: Importance.high,
//   );

//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin
//       >()
//       ?.createNotificationChannel(channel);
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   final NetworkController networkController = Get.find();
//   MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final themeController = Get.find<ThemeController>();

//     return Obx(() {
//       final bool isDark = themeController.isDarkMode.value;
//       if (!networkController.hasInternet.value) {
//         return MaterialApp(
//           home: NoInternetPage(
//             onRetry: networkController.retryConnection,
//             isDark: isDark,
//           ),
//         );
//       } 
//       return GetMaterialApp(
//           title: 'DropGo',
//           debugShowCheckedModeBanner: false,
//           translations: AppTranslations(),
//           locale: Get.deviceLocale,
//           fallbackLocale: const Locale('en', 'US'),
//           theme: AppTheme.theme,
//           darkTheme: AppTheme.darkTheme,
//           themeMode: themeController.isDarkMode.value
//               ? ThemeMode.dark
//               : ThemeMode.light,
//           initialRoute: AppRoutes.splash,
//           getPages: AppRoutes.routes,
//         );
//       }
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'firebase_options.dart';
import 'app/controllers/theme_controller.dart';
import 'app/controllers/network_controller.dart';
import 'app/constants/app_theme.dart';
import 'app/constants/translations.dart';
import 'app/routes/app_routes.dart';
import 'app/views/network_screen.dart';
import 'app/controllers/deliveryorder_controller.dart';
import 'app/constants/token_interceptor.dart';
import 'app/constants/Api_service.dart';
import 'app/constants/Api_constants.dart';

// Local notification setup
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// 🔹 Background message handler
@pragma('vm:entry-point') // REQUIRED for AOT
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('🔔 Background message received: ${message.notification?.title}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // Initialize APIs / Controllers
  final authApi = DeliveryAuthApis();
  authApi.setupInterceptors();
  Get.put(ThemeController());
  Get.put(NetworkController());
  Get.put(DeliveryAuthApis());

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Request notification permissions
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  print('🔔 User granted permission: ${settings.authorizationStatus}');

  // Register background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Local notifications setup
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initSettings =
      InitializationSettings(android: androidSettings);

  await flutterLocalNotificationsPlugin.initialize(
    initSettings,
    onDidReceiveNotificationResponse: (details) {
      print('Notification clicked: ${details.payload}');
    },
  );

  // Android 8+ notification channel
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.high,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // Foreground message handler
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('🔔 Foreground message: ${message.notification?.title}');
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: 'High importance notifications',
            icon: '@mipmap/ic_launcher',
          ),
        ),
      );
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final NetworkController networkController = Get.find();
    final ThemeController themeController = Get.find();

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
        themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
        initialRoute: AppRoutes.splash,
        getPages: AppRoutes.routes,
      );
    });
  }
}
