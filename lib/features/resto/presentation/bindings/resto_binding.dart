

import 'package:get/get.dart';
import 'package:learning/features/home/presentation/states/home_controller.dart';
import 'package:learning/features/resto/presentation/states/resto_controller.dart';

class RestoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RestoController(), permanent: true);
    Get.put(HomeController(), permanent: true);
  }
}