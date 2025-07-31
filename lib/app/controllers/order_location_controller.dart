import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:image/image.dart' as img;

class OrderLocationController extends GetxController {
  final googleApiKey = "AIzaSyCI_JG6kQjOnZnNauPmxuv-3YOL8D5ILhs";

  Rx<LatLng> currentPosition = const LatLng(11.2588, 75.7804).obs;
  Rx<LatLng> deliveryPosition = const LatLng(11.194716, 75.800501).obs;

  final polylineCoordinates = <LatLng>[].obs;
  final navigationSteps = <Map<String, dynamic>>[].obs;

  BitmapDescriptor vehicleIcon = BitmapDescriptor.defaultMarker;
  var isVehicleIconLoaded = false.obs;
  var _mapReady = false;
  var _routePending = false;

  late GoogleMapController _mapController;
  StreamSubscription<Position>? _positionStreamSubscription;
  DateTime? _lastRouteUpdate;
  double _heading = 0.0;

  @override
  void onInit() {
    super.onInit();
    _loadCustomIcon();
    _startLiveTracking();
  }

  @override
  void onClose() {
    _positionStreamSubscription?.cancel();
    _mapController.dispose();
    super.onClose();
  }

  Future<void> _loadCustomIcon() async {
    try {
      const assetPath = 'assets/images/boy.png';
      final ByteData data = await rootBundle.load(assetPath);
      final Uint8List bytes = data.buffer.asUint8List();

      final image = img.decodeImage(bytes);
      if (image == null) return;

      final resizedImage = img.copyResize(image, width: 64, height: 64);
      final resizedBytes = Uint8List.fromList(img.encodePng(resizedImage));

      vehicleIcon = BitmapDescriptor.fromBytes(resizedBytes);
      isVehicleIconLoaded.value = true;
    } catch (_) {
      vehicleIcon = BitmapDescriptor.defaultMarker;
    }
  }

  void setMapController(GoogleMapController controller) {
    _mapController = controller;
    _mapReady = true;

    if (_routePending) {
      _debouncedGetRoute();
    } else {
      getPolylineRoute();
    }
  }

  Future<void> _startLiveTracking() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) return;

    final pos = await Geolocator.getCurrentPosition();
    currentPosition.value = LatLng(pos.latitude, pos.longitude);
    _heading = pos.heading;

    _debouncedGetRoute();

    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 10),
    ).listen((Position pos) {
      currentPosition.value = LatLng(pos.latitude, pos.longitude);
      _heading = pos.heading;
      _debouncedGetRoute();
    });
  }

  void _debouncedGetRoute() {
    if (!_mapReady) {
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

  Future<void> getPolylineRoute() async {
    try {
      final origin = currentPosition.value;
      final destination = deliveryPosition.value;

      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json'
        '?origin=${origin.latitude},${origin.longitude}'
        '&destination=${destination.latitude},${destination.longitude}'
        '&mode=driving&key=$googleApiKey',
      );

      final response = await http.get(url);
      if (response.statusCode != 200) return;

      final data = json.decode(response.body);
      if (data['status'] != 'OK') return;

      final route = data['routes'][0];
      final leg = route['legs'][0];
      final encodedPolyline = route['overview_polyline']['points'];

      polylineCoordinates.value = _decodePolyline(encodedPolyline);

      navigationSteps.value = leg['steps'].map<Map<String, dynamic>>((step) {
        final doc = parse(step['html_instructions']);
        return {
          'instruction': doc.body?.text ?? '',
          'distance': step['distance']['text'],
          'duration': step['duration']['text'],
        };
      }).toList();

      final bounds = _boundsFromLatLngList(polylineCoordinates);
      _mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    } catch (e) {
      debugPrint('Error fetching polyline: $e');
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
      lat += (result & 1) != 0 ? ~(result >> 1) : (result >> 1);

      shift = 0;
      result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      lng += (result & 1) != 0 ? ~(result >> 1) : (result >> 1);

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
          color: Colors.blue,
          width: 5,
          points: polylineCoordinates,
        ),
      };

  Set<Marker> get markers => {
        Marker(
          markerId: const MarkerId("you"),
          position: currentPosition.value,
          icon: isVehicleIconLoaded.value ? vehicleIcon : BitmapDescriptor.defaultMarker,
          rotation: _heading,
          flat: true,
          anchor: const Offset(0.5, 0.5),
        ),
        Marker(
          markerId: const MarkerId("delivery"),
          position: deliveryPosition.value,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      };
}
