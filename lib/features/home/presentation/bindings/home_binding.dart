

import 'package:get/get.dart';
import 'package:learning/features/home/presentation/states/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
  }
}