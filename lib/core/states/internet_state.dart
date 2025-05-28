import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:learning/core/screens/no_internet_connection_screen.dart';

class InternetCheckerState extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    final isDisconnected = results.every((result) => result == ConnectivityResult.none);
    if (isDisconnected) {
      Get.to(() => const NoInternetConnectionScreen());
    } else {
      Get.back();
    }
  }
}
