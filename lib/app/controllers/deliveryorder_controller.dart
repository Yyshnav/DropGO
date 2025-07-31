import 'package:dropgo/app/constants/Api_service.dart';
import 'package:dropgo/app/constants/colors.dart';
import 'package:dropgo/app/models/delivery_order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:html/parser.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationController extends GetxController {
  final String phoneNumber = '+919995518067';

  var currentPosition = const LatLng(11.2588, 75.7804).obs;
  var deliveryPosition = const LatLng(11.194716, 75.800501).obs;
  var expandedTile = "".obs;
  final polylineCoordinates = <LatLng>[].obs;
  final navigationSteps = <Map<String, dynamic>>[].obs;
  var isVehicleIconLoaded = false.obs;
  var deliveryOrder = Rxn<DeliveryOrder>();
  bool _mapReady = false;
  bool _routePending = false;
  


  late GoogleMapController _mapController;
  BitmapDescriptor vehicleIcon = BitmapDescriptor.defaultMarker;
  StreamSubscription<Position>? _positionStreamSubscription;
  DateTime? _lastRouteUpdate;
  double _heading = 0.0;

  final String googleApiKey = "AIzaSyCI_JG6kQjOnZnNauPmxuv-3YOL8D5ILhs";

  @override
  void onInit() {
    super.onInit();
    _loadVehicleIcon();
    _startLocationUpdates();
  }

  @override
  void onClose() {
    _positionStreamSubscription?.cancel();
    _mapController.dispose();
    super.onClose();
  }

  // ✅ Launch Phone Call
  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }


  // ✅ Load Custom Vehicle Marker Icon
  Future<void> _loadVehicleIcon() async {
    try {
      if (Get.context == null) return;

      const assetPath = 'assets/images/boy.png';
      final ByteData data = await DefaultAssetBundle.of(Get.context!).load(assetPath);
      final Uint8List bytes = data.buffer.asUint8List();

      final image = img.decodeImage(bytes);
      if (image == null) throw Exception('Failed to decode image');

      final resizedImage = img.copyResize(image, width: 64, height: 64);
      final resizedBytes = Uint8List.fromList(img.encodePng(resizedImage));

      vehicleIcon = BitmapDescriptor.fromBytes(resizedBytes);
      isVehicleIconLoaded.value = true;
    } catch (e) {
      isVehicleIconLoaded.value = false;
      vehicleIcon = BitmapDescriptor.defaultMarker;
    }
  }

  void setMapController(GoogleMapController controller) {
  _mapController = controller;
}

  // ✅ Start Live Location Tracking
  Future<void> _startLocationUpdates() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar('Error', 'Please enable location services');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar('Error', 'Location permissions denied');
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        Get.snackbar('Error', 'Location permissions permanently denied');
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      );

      currentPosition.value = LatLng(position.latitude, position.longitude);
      _heading = position.heading;

      // getPolylineRoute();
      _debouncedGetPolylineRoute();

      _positionStreamSubscription = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 10),
      ).listen((Position position) {
        _heading = position.heading;
        currentPosition.value = LatLng(position.latitude, position.longitude);
        _debouncedGetPolylineRoute();
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to start location updates');
    }
  }

  // void _debouncedGetPolylineRoute() {
  //   final now = DateTime.now();
  //   if (_lastRouteUpdate == null || now.difference(_lastRouteUpdate!) > const Duration(seconds: 30)) {
  //     getPolylineRoute();
  //     _lastRouteUpdate = now;
  //   }
  // }
void _debouncedGetPolylineRoute() {
  if (!_mapReady) {
    print("⚠️ Map not ready, delaying polyline update.");
    _routePending = true;
    return;
  }

  final now = DateTime.now();
  if (_lastRouteUpdate == null || now.difference(_lastRouteUpdate!) > const Duration(seconds: 30)) {
    getPolylineRoute();
    _lastRouteUpdate = now;
    _routePending = false;
  }
}

  final authApi = DeliveryAuthApis();
  // ✅ Fetch Order from Backend
//   Future<void> fetchOrderDetails(String orderId) async {
//     try {
//       final order = await authApi.getOrderDetails(orderId); // Assuming static method
//       // if (order != null) {
//       if (order != null|| order!.orderId.isNotEmpty) { 
//         deliveryOrder.value = order;

//         currentPosition.value = LatLng(order.pickupLat!, order.pickupLng!);
//         deliveryPosition = LatLng(order.deliveryLat!, order.deliveryLng!).obs;

//         // getPolylineRoute();
//         if (_mapReady) {
//   getPolylineRoute();
// } else {
//   print("⚠️ Map not ready, skipping polyline draw in fetchOrderDetails");
// }
//       } else {
//         Get.snackbar("Error", "Failed to load order details");
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Could not fetch order");
//     }
//   }

Future<void> fetchOrderDetails(String orderId) async {
  try {
    final order = await authApi.getOrderDetails(orderId);

    if (order == null || order.orderId.isEmpty) {
      // If no pending order, clear delivery order
      deliveryOrder.value = null;
      Get.snackbar("Fetching order...","No pending order found");
      print("No pending order found");
      // Show delivery boy's current location only
      await setDeliveryBoyCurrentLocation();
      return;
    }

    // If order is not empty, update UI
    deliveryOrder.value = order;

    currentPosition.value = LatLng(order.pickupLat!, order.pickupLng!);
    deliveryPosition.value = LatLng(order.deliveryLat!, order.deliveryLng!);

    if (_mapReady) {
      getPolylineRoute();
    } else {
      print("⚠️ Map not ready, skipping polyline draw in fetchOrderDetails");
    }

  } catch (e) {
    Get.snackbar("Error", "Could not fetch order");
  }
}

Future<void> setDeliveryBoyCurrentLocation() async {
  // Use GPS to get current location
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  currentPosition.value = LatLng(position.latitude, position.longitude);

  markers.clear();
  markers.add(
    Marker(
      markerId: const MarkerId("delivery_boy"),
      position: currentPosition.value,
      icon:isVehicleIconLoaded.value ? vehicleIcon : BitmapDescriptor.defaultMarker, // custom icon if you have
    ),
  );
}


  void onMapCreated(GoogleMapController controller) {
  _mapController = controller;
  _mapReady = true;
  if (_routePending) {
    print("📍 Drawing pending polyline route");
    _debouncedGetPolylineRoute();
  } else {
    getPolylineRoute(); // or skip if already called
  }
}

  void toggleTile(String type) {
    expandedTile.value = expandedTile.value == type ? "" : type;
    if (type == "delivery") {
      animateToDelivery();
      getPolylineRoute();
    }
  }

  void animateToDelivery() {
    _mapController.animateCamera(CameraUpdate.newLatLngZoom(deliveryPosition.value, 15));
  }

  // Future<void> getPolylineRoute() async {
  //   try {
  //     final url = Uri.parse(
  //       'https://maps.googleapis.com/maps/api/directions/json'
  //       '?origin=${currentPosition.value.latitude},${currentPosition.value.longitude}'
  //       '&destination=${deliveryPosition.value.latitude},${deliveryPosition.value.longitude}'
  //       '&mode=driving'
  //       '&key=$googleApiKey',
  //     );

  //     final response = await http.get(url);
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final data = json.decode(response.body);
  //       if (data['status'] == 'OK') {
  //         final route = data['routes'][0];
  //         final leg = route['legs'][0];

  //         final encodedPolyline = route['overview_polyline']['points'];
  //         polylineCoordinates.value = _decodePolyline(encodedPolyline);

  //         navigationSteps.value = leg['steps'].map<Map<String, dynamic>>((step) {
  //           final document = parse(step['html_instructions']);
  //           final cleanInstruction = document.body?.text ?? step['html_instructions'];
  //           return {
  //             'instruction': cleanInstruction,
  //             'distance': step['distance']['text'] ?? '',
  //             'duration': step['duration']['text'] ?? '',
  //           };
  //         }).toList();

  //         final bounds = _boundsFromLatLngList(polylineCoordinates);
  //         _mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  //       } else {
  //         Get.snackbar('Error', 'No route found');
  //       }
  //     } else {
  //       Get.snackbar('Error', 'Route request failed');
  //     }
  //   } catch (e) {
  //      print("❌ getPolylineRoute() exception: $e");
  //     Get.snackbar('Error', 'Failed to fetch route');
  //   }
  // }
  Future<void> getPolylineRoute() async {
  try {
    final originLat = currentPosition.value.latitude;
    final originLng = currentPosition.value.longitude;
    final destLat = deliveryPosition.value.latitude;
    final destLng = deliveryPosition.value.longitude;

    print("📍 Origin: $originLat, $originLng");
    print("📍 Destination: $destLat, $destLng");

    // Prevent sending invalid requests
    if (originLat == 0.0 || originLng == 0.0 || destLat == 0.0 || destLng == 0.0) {
      print("⚠️ Coordinates not valid yet. Skipping route fetch.");
      return;
    }

    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/directions/json'
      '?origin=$originLat,$originLng'
      '&destination=$destLat,$destLng'
      '&mode=driving'
      '&key=$googleApiKey',
    );

    final response = await http.get(url);

    print("📡 API URL: $url");
    print("📡 Status Code: ${response.statusCode}");
    print("📡 Response Body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        final route = data['routes'][0];
        final leg = route['legs'][0];

        final encodedPolyline = route['overview_polyline']['points'];
        polylineCoordinates.value = _decodePolyline(encodedPolyline);

        navigationSteps.value = leg['steps'].map<Map<String, dynamic>>((step) {
          final document = parse(step['html_instructions']);
          final cleanInstruction = document.body?.text ?? step['html_instructions'];
          return {
            'instruction': cleanInstruction,
            'distance': step['distance']['text'] ?? '',
            'duration': step['duration']['text'] ?? '',
          };
        }).toList();

        final bounds = _boundsFromLatLngList(polylineCoordinates);
        _mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
      } else {
        final errorMessage = data['error_message'] ?? data['status'];
        print("❌ Google Maps API returned error: $errorMessage");
        Get.snackbar('Route Error', 'No route found: $errorMessage');
      }
    } else {
      print("❌ API Request failed with status: ${response.statusCode}");
      Get.snackbar('Route Error', 'Route request failed: ${response.statusCode}');
    }
  } catch (e) {
    print("❌ Exception in getPolylineRoute(): $e");
    Get.snackbar('Route Error', 'Failed to fetch route');
  }
}


  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, lat = 0, lng = 0;

    while (index < encoded.length) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0) ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0) ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

  LatLngBounds _boundsFromLatLngList(List<LatLng> list) {
    final swLat = list.map((p) => p.latitude).reduce(min);
    final swLng = list.map((p) => p.longitude).reduce(min);
    final neLat = list.map((p) => p.latitude).reduce(max);
    final neLng = list.map((p) => p.longitude).reduce(max);
    return LatLngBounds(southwest: LatLng(swLat, swLng), northeast: LatLng(neLat, neLng));
  }

  Set<Polyline> get routePolyline => {
    Polyline(
      polylineId: const PolylineId("route"),
      color: AppColors.primary,
      width: 4,
      points: polylineCoordinates,
    ),
  };

  Set<Marker> get markers => {
    Marker(
      markerId: const MarkerId("currentLocation"),
      position: currentPosition.value,
      infoWindow: const InfoWindow(title: "You are here"),
      icon: isVehicleIconLoaded.value ? vehicleIcon : BitmapDescriptor.defaultMarker,
      rotation: _heading,
      flat: true,
      anchor: const Offset(0.5, 0.5),
    ),
    Marker(
      markerId: const MarkerId("deliveryLocation"),
      position: deliveryPosition.value,
      infoWindow: const InfoWindow(title: "Delivery Location"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ),
  };
}
