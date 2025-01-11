
import 'package:get/get.dart';
import 'package:learning/core/resources/storage_keys.dart';
import 'package:learning/core/services/storage_manager.dart';

class AuthCheckerState extends GetxController{

  @override
  void onInit() {
    super.onInit();
    checkAuthUser();
  }

  bool checkAuthUser() {
    return StorageManager.instance.getBoolValue(key: StorageKey.isAuthKey) == true;
  }
}