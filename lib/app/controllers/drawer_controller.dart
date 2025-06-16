// drawer_controller.dart
import 'package:get/get.dart';

class DrawerControllerX extends GetxController {
  var selectedItem = 'Calendar'.obs;

  void setSelected(String item) {
    selectedItem.value = item;
  }
}
