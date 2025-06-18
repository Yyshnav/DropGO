import 'package:dropgo/app/constants/colors.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:html/parser.dart' show parse;
// import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationController extends GetxController {
  final String phoneNumber = '+919995518067';
  var currentPosition = const LatLng(11.2588, 75.7804).obs; // Fallback position
  var expandedTile = "".obs;
  late GoogleMapController _mapController;
  final polylineCoordinates = <LatLng>[].obs;
  var isVehicleIconLoaded = false.obs;
  final navigationSteps =
      <Map<String, dynamic>>[].obs; // Store turn-by-turn steps

  final deliveryPosition = const LatLng(11.194716, 75.800501);
  final String googleApiKey = "AIzaSyCI_JG6kQjOnZnNauPmxuv-3YOL8D5ILhs";

  BitmapDescriptor vehicleIcon =
      BitmapDescriptor.defaultMarker; // Default fallback
  StreamSubscription<Position>?
  _positionStreamSubscription; // Store stream subscription
  DateTime? _lastRouteUpdate; // For debouncing route updates

  @override
  void onInit() {
    super.onInit();
    _loadVehicleIcon();
    _startLocationUpdates();
  }

  @override
  void onClose() {
    _positionStreamSubscription?.cancel(); // Cancel stream to prevent leaks
    _mapController.dispose();
    super.onClose();
  }

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri uri = Uri(scheme: 'tel', path: phoneNumber);

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $uri';
  }
}
  
  Future<void> _loadVehicleIcon() async {
    try {
      if (Get.context == null) {
        throw Exception('Get.context is null');
      }

      const assetPath = 'assets/images/boy.png';
      // print('Attempting to load asset: $assetPath');
      final ByteData data = await DefaultAssetBundle.of(
        Get.context!,
      ).load(assetPath);
      final Uint8List bytes = data.buffer.asUint8List();
      // print('Asset loaded, bytes length: ${bytes.length}');

      final image = img.decodeImage(bytes);
      if (image == null) {
        throw Exception('Failed to decode image: $assetPath');
      }
      final resizedImage = img.copyResize(image, width: 48, height: 48);
      final resizedBytes = Uint8List.fromList(img.encodePng(resizedImage));

      vehicleIcon = BitmapDescriptor.bytes(resizedBytes);
      isVehicleIconLoaded.value = true;
      // print('Vehicle icon loaded successfully');
    } catch (e) {
      // print('Error loading vehicle icon: $e');
      isVehicleIconLoaded.value = false;
      vehicleIcon = BitmapDescriptor.defaultMarker;
    }
  }

  Future<void> _startLocationUpdates() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // print('Location services are disabled');
        Get.snackbar('Error', 'Please enable location services');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // print('Location permissions denied');
          Get.snackbar('Error', 'Location permissions denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // print('Location permissions permanently denied');
        Get.snackbar('Error', 'Location permissions permanently denied');
        return;
      }

      // Initial position fetch
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
      );
      //   desiredAccuracy: LocationAccuracy.high,

      currentPosition.value = LatLng(position.latitude, position.longitude);
      getPolylineRoute(); // Initial route fetch

      // Start real-time location updates
      _positionStreamSubscription =
          Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.high,
              distanceFilter: 10, // Update every 10 meters
            ),
          ).listen(
            (Position position) {
              currentPosition.value = LatLng(
                position.latitude,
                position.longitude,
              );
              // print('Updated current position: ${currentPosition.value}');
              _debouncedGetPolylineRoute();
            },
            onError: (e) {
              // print('Position stream error: $e');
            },
          );
    } catch (e) {
      // print('Error starting location updates: $e');
      Get.snackbar('Error', 'Failed to start location updates');
    }
  }

  void _debouncedGetPolylineRoute() {
    final now = DateTime.now();
    if (_lastRouteUpdate == null ||
        now.difference(_lastRouteUpdate!) > const Duration(seconds: 30)) {
      getPolylineRoute();
      _lastRouteUpdate = now;
    }
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    getPolylineRoute(); // Initial route fetch
  }

  void toggleTile(String type) {
    expandedTile.value = expandedTile.value == type ? "" : type;
    if (type == "delivery") {
      animateToDelivery();
      getPolylineRoute();
    }
  }

  void animateToDelivery() {
    _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(deliveryPosition, 15),
    );
  }

  // Decode encoded polyline string to LatLng points
  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

  Future<void> getPolylineRoute() async {
    try {
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json'
        '?origin=${currentPosition.value.latitude},${currentPosition.value.longitude}'
        '&destination=${deliveryPosition.latitude},${deliveryPosition.longitude}'
        '&mode=driving'
        '&key=$googleApiKey',
      );

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          final route = data['routes'][0];
          final leg = route['legs'][0];

          // Extract polyline points
          final encodedPolyline = route['overview_polyline']['points'];
          polylineCoordinates.value = _decodePolyline(encodedPolyline);

          // Extract navigation steps
          navigationSteps.value = leg['steps'].map<Map<String, dynamic>>((
            step,
          ) {
            final document = parse(step['html_instructions']);
            final cleanInstruction =
                document.body?.text ?? step['html_instructions'];
            return {
              'instruction': cleanInstruction,
              'distance': step['distance']['text'] ?? '',
              'duration': step['duration']['text'] ?? '',
            };
          }).toList();

          // Adjust map to show the entire route
          final bounds = _boundsFromLatLngList(polylineCoordinates);
          _mapController.animateCamera(
            CameraUpdate.newLatLngBounds(bounds, 50),
          );
          // print('Polyline loaded with ${polylineCoordinates.length} points, ${navigationSteps.length} steps');
        } else {
          // print('Directions API error: ${data['status']}');
          Get.snackbar('Error', 'No route found: ${data['status']}');
        }
      } else {
        // print('HTTP request failed: ${response.statusCode}');
        Get.snackbar('Error', 'Failed to fetch route');
      }
    } catch (e) {
      // print('Error fetching polyline route: $e');
      Get.snackbar('Error', 'Failed to fetch route');
    }
  }

  LatLngBounds _boundsFromLatLngList(List<LatLng> list) {
    final southwestLat = list
        .map((p) => p.latitude)
        .reduce((a, b) => a < b ? a : b);
    final southwestLng = list
        .map((p) => p.longitude)
        .reduce((a, b) => a < b ? a : b);
    final northeastLat = list
        .map((p) => p.latitude)
        .reduce((a, b) => a > b ? a : b);
    final northeastLng = list
        .map((p) => p.longitude)
        .reduce((a, b) => a > b ? a : b);

    return LatLngBounds(
      southwest: LatLng(southwestLat, southwestLng),
      northeast: LatLng(northeastLat, northeastLng),
    );
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
      icon: isVehicleIconLoaded.value
          ? vehicleIcon
          : BitmapDescriptor.defaultMarker,
    ),
    Marker(
      markerId: const MarkerId("deliveryLocation"),
      position: deliveryPosition,
      infoWindow: const InfoWindow(title: "Delivery Location"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ),
  };
}
