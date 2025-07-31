import 'package:dropgo/app/constants/Api_service.dart';
import 'package:dropgo/app/models/Delivery_userProfile.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  Rx<DeliveryUser?> user = Rx<DeliveryUser?>(null);
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    isLoading.value = true;
    final result = await DeliveryAuthApis.fetchProfile();
    user.value = result;
    isLoading.value = false;
  }

void updateUser({
  required String name,
  required String email,
  required String phone,
  String? image,
}) {
  user.value = user.value?.copyWith(
    name: name,
    email: email,
    phone: phone,
    image: image ?? user.value?.image,
  );
}
}
