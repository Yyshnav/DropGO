import 'dart:developer';

import 'package:dropgo/app/constants/Api_service.dart';
import 'package:dropgo/app/routes/app_routes.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FeedbackController extends GetxController {
  final RxDouble customerRating = 0.0.obs;
  final RxBool showFeedbackField = false.obs;
  final feedbackController = TextEditingController();
  final DeliveryAuthApis _apiService = DeliveryAuthApis();

  void setRating(double rating) {
    customerRating.value = rating;
    showFeedbackField.value = rating == 1.0;
    if (!showFeedbackField.value) {
      feedbackController.clear();
    }
  }

  Future<void> submitFeedback(String orderId) async {
    if (customerRating.value == 0.0) {
      Get.snackbar("Rating Missing", "Please provide a rating");
      return;
    }

    try {
      final payload = {
        'order_id': orderId,
        'rating': customerRating.value,
        'feedback': feedbackController.text.isEmpty ? null : feedbackController.text,
      };
      log("Submitting feedback: $payload");

      final response = await _apiService.submitFeedback(payload);
      print("Feedback Response: ${response.statusCode}, ${response.data}");

      Get.snackbar("Feedback Submitted", "Thanks for rating the customer!");
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      log("Feedback submission error: $e");
      Get.snackbar("Error", "Failed to submit feedback: $e");
    }
  }

  void clearFeedback() {
    showFeedbackField.value = false;
    feedbackController.clear();
  }

  @override
  void onClose() {
    feedbackController.dispose();
    super.onClose();
  }
}