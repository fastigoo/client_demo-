import 'package:get/get.dart';
import 'package:client/features/cart/presentation/states/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CartController(), permanent: true);
  }
}