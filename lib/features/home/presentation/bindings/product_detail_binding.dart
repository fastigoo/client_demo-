import 'package:get/get.dart';
import 'package:learning/features/home/presentation/states/product_detail_controller.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductDetailController(), permanent: true);
  }
}