import 'dart:math';

import 'package:dropgo/app/constants/Api_service.dart';
import 'package:dropgo/app/models/all_orders_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderProgressController extends GetxController {
  final _api = DeliveryAuthApis();

  /// All fetched orders (you can filter later by status if needed)
  final orders = <OrderModel>[].obs;

  /// Parallel computed values
  final distancesKm = <double>[].obs;
  final timesMin = <int>[].obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadOrders();
  }

  Future<void> loadOrders() async {
    isLoading.value = true;
    final data = await _api.fetchAllOrders();
    orders.assignAll(data);
    _computeDistanceAndTime();
    isLoading.value = false;
  }

  void _computeDistanceAndTime() {
    distancesKm.clear();
    timesMin.clear();

    for (final o in orders) {
      final d = _haversineKm(o.pickupLat, o.pickupLng, o.dropLat, o.dropLng);
      distancesKm.add(d);

      // simple ETA estimate @ 40 km/h average
      final mins = (d / 40 * 60).round().clamp(1, 9999);
      timesMin.add(mins);
    }
  }

  double _haversineKm(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371.0; // Earth radius km
    final dLat = _deg2rad(lat2 - lat1);
    final dLon = _deg2rad(lon2 - lon1);
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_deg2rad(lat1)) * cos(_deg2rad(lat2)) *
            sin(dLon / 2) * sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  double _deg2rad(double deg) => deg * (pi / 180.0);
}