import 'package:get/get.dart';
import 'package:client/features/free_order/presentation/states/free_order_controller.dart';

class FreeOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FreeOrderController>(() => FreeOrderController(), fenix: true);
  }
}
