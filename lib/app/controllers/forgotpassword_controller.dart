import 'package:dropgo/app/constants/Api_service.dart';
import 'package:dropgo/app/routes/app_routes.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final email = ''.obs;
  final isLoading = false.obs;

  final DeliveryAuthApis _api = DeliveryAuthApis();

  Future<void> submitForgotPassword() async {
    if (email.value.isEmpty || !email.value.isEmail) {
      Get.snackbar('Error', 'Please enter a valid email');
      return;
    }

    try {
      isLoading.value = true;
      await _api.requestPasswordReset(email.value);
      Get.toNamed(AppRoutes.otp, arguments: email.value);
      Get.snackbar('Success', 'Reset link sent to your email');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}