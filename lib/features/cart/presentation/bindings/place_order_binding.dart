import 'package:get/get.dart';
import 'package:learning/features/cart/presentation/states/place_order_controller.dart';

class PlaceOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PlaceOrderController());
  }
}