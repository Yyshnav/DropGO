import 'dart:convert';
import 'dart:async';
// import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class EmergencyController extends GetxController {
  var locationName = 'Fetching location...'.obs;
  var place = ''.obs;
  var countryCode = 'IN'; // default
  var emergencyNumbers = RxMap<String, String>({});
  var selectedType = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _initLocationAndNumbers();
  }

  Future<void> _initLocationAndNumbers() async {
    await _fetchLocation();
    await _fetchEmergencyNumbers();
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

      var placemarks =
          await placemarkFromCoordinates(pos.latitude, pos.longitude);
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        locationName.value = '${p.street}, ${p.subLocality ?? ''}';
        place.value = '${p.locality ?? ''}, ${p.country ?? ''}';
        countryCode = p.isoCountryCode ?? countryCode;
      }
    } catch (e) {
      locationName.value = 'Location error';
      place.value = e.toString();
    }
  }

  Future<void> _fetchEmergencyNumbers() async {
    try {
      final url =
          Uri.parse('https://emergencynumberapi.com/api/country/$countryCode');
      final res = await http.get(url);
      if (res.statusCode == 200) {
        final json = jsonDecode(res.body)['data'];
        emergencyNumbers.value = {
          'Police': (json['Police']?['All'] as List).cast<String>().firstOrNull ?? '',
          'Fire': (json['Fire']?['All'] as List).cast<String>().firstOrNull ?? '',
          'Medical': (json['Ambulance']?['All'] as List).cast<String>().firstOrNull ?? '',
          'Dispatch': (json['Dispatch']?['All'] as List).cast<String>().firstOrNull ?? '',
        };
      } else {
        throw Exception('API error');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed loading emergency numbers');
    }
  }

  Future<void> makeEmergencyCall(String type) async {
    final num = emergencyNumbers[type] ??
        emergencyNumbers['Dispatch'] ??
        emergencyNumbers.values.firstOrNull ??
        '112';
    final uri = Uri(scheme: 'tel', path: num);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Get.snackbar('Error', 'Could not launch dialer');
    }
  }

  void selectEmergency(String label) {
    selectedType.value = label;
    makeEmergencyCall(label);
  }
  void refreshLocation(){
    _fetchLocation();
  }
}
