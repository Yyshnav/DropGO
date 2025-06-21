import 'package:dropgo/app/routes/app_routes.dart';
import 'package:get/get.dart';

class DrawerControllerX extends GetxController {
  var selectedItem = 'My orders'.obs;

  final Map<String, String> routeMap = {
    'My Account': AppRoutes.myaccount,
    'My orders': AppRoutes.orderhistory,
    'Support': AppRoutes.help,
    'App feedback': AppRoutes.appfeedback, // Use the correct screen if available
  };

  void setSelected(String item) {
    selectedItem.value = item;

    final route = routeMap[item];
    if (route != null && Get.currentRoute != route) {
      Get.back(); // Close drawer
      Future.delayed(Duration(milliseconds: 300), () {
        Get.toNamed(route);
      });
    }
  }
}
