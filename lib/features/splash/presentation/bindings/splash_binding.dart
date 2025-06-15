

import 'package:get/get.dart';
import 'package:client/features/splash/presentation/states/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController(), permanent: true);
  }
}