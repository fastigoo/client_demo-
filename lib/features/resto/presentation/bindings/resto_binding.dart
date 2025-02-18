

import 'package:get/get.dart';
import 'package:learning/features/resto/presentation/states/resto_controller.dart';

class RestoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RestoController>(() => RestoController(), fenix: true);
  }
}