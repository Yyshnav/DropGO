import 'package:dropgo/app/constants/Api_service.dart';
import 'package:dropgo/app/models/all_orders_model.dart';
import 'package:dropgo/app/models/order_datail_model.dart';
import 'package:get/get.dart';
// class OrderController extends GetxController {
//   var isPickedUp = false.obs;
//   var isDelivered = false.obs;

//   void confirmPickup() {
//     isPickedUp.value = true;
//     Get.snackbar("Pickup Confirmed", "Thank you!");
//   }

//   void deliverOrder() {
//     isDelivered.value = true;
//     Get.snackbar("Order Delivered", "Thank you!");
//   }
// }

// class OrderController extends GetxController {
//   var order = Rxn<OrderDetailModel>();
//   var isLoading = false.obs;

//   final DeliveryAuthApis _api = DeliveryAuthApis();

//   Future<void> fetchOrderDetails(String orderId) async {
//     isLoading.value = true;
//     try {
//       order.value = await _api.OrderDetails(orderId);
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> updateStatus(String status) async {
//     if (order.value == null) return;
//     await _api.updateOrderStatus(order.value!.orderId, status);
//     Get.snackbar("Success", "Order status updated to $status");
//   }
// }

class OrderController extends GetxController {
  var order = Rxn<OrderDetailModel>();
  var isLoading = false.obs;
  var isPickedUp = false.obs;
  var isDelivered = false.obs;

  final DeliveryAuthApis _api = DeliveryAuthApis();
  var isPaymentConfirmed = false.obs;
var selectedPaymentType = "".obs;

  Future<void> fetchOrderDetails(String orderId) async {
    isLoading.value = true;
    try {
      order.value = await _api.orderDetails(orderId);

      // Update status flags based on fetched data
      if (order.value != null) {
        if (order.value!.status == "picked_up") {
          isPickedUp.value = true;
        }
        if (order.value!.status == "delivered") {
          isDelivered.value = true;
        }
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateStatus(String status, {bool paymentDone = false, String? paymentType}) async {
    if (order.value == null) return;

    try {
      await _api.updateOrderStatus(order.value!.orderId, status, paymentDone: paymentDone, paymentType: paymentType);

      // Update local order status
      order.value!.status = status;

      if (status == "OUT_FOR_DELIVERY") {
        isPickedUp.value = true;
      } else if (status == "DELIVERED") {
        isDelivered.value = true;
      }

      Get.snackbar("Success", "Order status updated to $status");
    } catch (e) {
      Get.snackbar("Error", "Failed to update status");
    }
  }
}
