import 'package:get/get.dart';
import 'package:learning/features/resto/presentation/states/free_orders_controller.dart';

class FreeOrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FreeOrdersController>(() => FreeOrdersController(), fenix: true);
  }
}
