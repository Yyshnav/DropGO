import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyController extends GetxController {
  var locationName = 'Fetching location...'.obs;
  var place = ''.obs;
  var selectedType = ''.obs;

  final Map<String, String> emergencyNumbers = {
    'Police': '999', // Qatar emergency
    'Admin': '+97412345678', // Replace with actual admin number if needed
  };

  @override
  void onInit() {
    super.onInit();
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    try {
      bool ok = await Geolocator.isLocationServiceEnabled();
      if (!ok) {
        locationName.value = 'Location disabled';
        return;
      }

      var perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) {
        perm = await Geolocator.requestPermission();
        if (perm == LocationPermission.denied) {
          locationName.value = 'Permission denied';
          return;
        }
      }

      if (perm == LocationPermission.deniedForever) {
        locationName.value = 'Permission permanently denied';
        return;
      }

      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
      );

      var placemarks = await placemarkFromCoordinates(pos.latitude, pos.longitude);
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        locationName.value = '${p.street}, ${p.subLocality ?? ''}';
        place.value = '${p.locality ?? ''}, ${p.country ?? ''}';
      }
    } catch (e) {
      locationName.value = 'Location error';
      place.value = e.toString();
    }
  }

  void refreshLocation() {
    _fetchLocation();
  }

void selectEmergency(String label) {
  selectedType.value = label;

  if (label == 'Call 999') {
    _callNumber('999');
  } else if (label == 'Contact Admin') {
    _callNumber('12345678'); // Replace with real admin number
  }
}

Future<void> _callNumber(String number) async {
  final uri = Uri(scheme: 'tel', path: number);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    Get.snackbar('Error', 'Could not launch dialer');
  }
}

}
