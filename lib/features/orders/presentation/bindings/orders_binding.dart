import 'package:get/get.dart';
import 'package:client/features/orders/presentation/states/orders_controller.dart';

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrdersController>(() => OrdersController(), fenix: true);
  }
}