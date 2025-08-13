import 'package:dropgo/app/constants/Api_service.dart';
import 'package:dropgo/app/models/all_orders_model.dart';
import 'package:dropgo/app/models/order_datail_model.dart';
import 'package:dropgo/app/routes/app_routes.dart';
import 'package:get/get.dart';


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
        if (order.value!.status == "Accepted") {
          isPickedUp.value = true;
        }
        if (order.value!.status == "Delivered") {
          isDelivered.value = true;
        }
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      print(e.toString());
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

      if (status == "ACCEPTED") {
        isPickedUp.value = true;
      } else if (status == "DELIVERED") {
        isDelivered.value = true;
        Get.offAndToNamed(AppRoutes.success, arguments: order.value!.orderId.toString());
      }

      Get.snackbar("Success", "Order status updated to $status");
    } catch (e) {
      Get.snackbar("Error", "Failed to update status");
      print("Error updating status: $e");
    }
  }
}
