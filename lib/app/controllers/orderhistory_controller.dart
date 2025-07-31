// import 'package:dropgo/app/constants/Api_service.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';


// class OrderHistoryController extends GetxController with GetSingleTickerProviderStateMixin {
//   late TabController tabController;
//   final DeliveryAuthApis _apiService = DeliveryAuthApis();

//   var completedOrders = [].obs;
//   var cancelledOrders = [].obs;
//   var isLoading = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     tabController = TabController(length: 2, vsync: this);
//     // fetchOrders();
//   }

//   // Future<void> fetchOrders() async {
//   //   isLoading.value = true;
//   //   try {
//   //     final orders = await _apiService.fetchOrders();

//   //     completedOrders.value =
//   //         orders.where((o) => o['orderstatus'] == 'COMPLETED').toList();
//   //     cancelledOrders.value =
//   //         orders.where((o) => o['orderstatus'] == 'CANCELLED').toList();
//   //   } catch (e) {
//   //     print("❌ Error fetching order history: $e");
//   //     // You may use Get.snackbar() or similar for UI error feedback
//   //   } finally {
//   //     isLoading.value = false;
//   //   }
//   // }
// }


import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dropgo/app/constants/Api_service.dart';
import 'package:dropgo/app/models/order_history_model.dart';

class OrderHistoryController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final DeliveryAuthApis _apiService = DeliveryAuthApis();

  var completedOrders = <OrderHistoryItem>[].obs;
  var cancelledOrders = <OrderHistoryItem>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    isLoading.value = true;
    try {
      final orders = await _apiService.fetchOrderHistory();

      completedOrders.value =
          orders.where((o) => o.orderStatus == 'DELIVERED' || o.orderStatus == 'COMPLETED').toList();
      cancelledOrders.value =
          orders.where((o) => o.orderStatus == 'CANCELLED').toList();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
