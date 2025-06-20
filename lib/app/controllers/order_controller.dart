import 'package:get/get.dart';

class OrderProgressController extends GetxController {
  var orders = List.generate(2, (index) => 'Order ${index + 1}').obs;
}
