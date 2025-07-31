import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  RxBool hasInternet = true.obs;

  @override
  void onInit() {
    super.onInit();
    _checkInitialStatus();

    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      final status = results.isNotEmpty ? results.first : ConnectivityResult.none;
      hasInternet.value = status != ConnectivityResult.none;
    });
  }

  Future<void> _checkInitialStatus() async {
    final result = await _connectivity.checkConnectivity();
    hasInternet.value = result != ConnectivityResult.none;
  }

  Future<void> retryConnection() async {
    final result = await _connectivity.checkConnectivity();
    hasInternet.value = result != ConnectivityResult.none;
  }
}
