

import 'package:get/get.dart';
import 'package:learning/features/profile/presentation/states/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileController());
  }
}