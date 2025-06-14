import 'package:get/get.dart';

class OrderController extends GetxController {
  var isPickedUp = false.obs;
  var isDelivered = false.obs;

  void confirmPickup() {
    isPickedUp.value = true;
    Get.snackbar("Pickup Confirmed", "Thank you!");
  }

  void deliverOrder() {
    isDelivered.value = true;
    Get.snackbar("Order Delivered", "Thank you!");
  }
}
