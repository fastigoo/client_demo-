import 'package:get/get.dart';
import 'package:client/features/settings/presentation/states/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}
