import 'dart:async';

import 'package:dropgo/app/constants/Api_service.dart';
import 'package:dropgo/app/routes/app_routes.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final DeliveryAuthApis _api = DeliveryAuthApis();
  var isLoading = false.obs;
  // String email = '';
  var timeLeft = 300.obs; // 5 minutes in seconds
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    timeLeft.value = 300; // reset to 5 minutes
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft.value > 0) {
        timeLeft.value--;
      } else {
        timer.cancel();
      }
    });
  }


  Future<void> verifyOtp(String email, String otp) async {
    isLoading.value = true;
    final success = await _api.verifyOtp(email: email, otp: otp);

    isLoading.value = false;

    // print('==============$email');
    if (success) {
      // print('==============$email');
      _timer?.cancel();
      Get.offAllNamed(AppRoutes.setnewpassword , arguments: email);

    } else {
      Get.snackbar('Error', 'Invalid OTP');
    }
  }

  Future<void> resendOtp(String email) async {
    if (timeLeft.value > 0) return;
    isLoading.value = true;
    final success = await _api.resendOtp(email);
    isLoading.value = false;

    if (success) {
      Get.snackbar('Success', 'OTP resent to email');
      startTimer(); 
    } else {
      Get.snackbar('Error', 'Failed to resend OTP');
    }
  }
  String get formattedTime {
    final minutes = (timeLeft.value ~/ 60).toString().padLeft(2, '0');
    final seconds = (timeLeft.value % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
