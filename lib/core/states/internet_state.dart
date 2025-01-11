import 'dart:async';

import 'package:get/get.dart';

class InternetCheckerState extends GetxController {

  var isConnectedToInternet = false.obs;
  StreamSubscription? internetStreamSubscription;
  //
  // @override
  // void onInit() {
  //   super.onInit();
  //   internetStreamSubscription = InternetConnection().onStatusChange.listen((event) {
  //     switch (event) {
  //       case InternetStatus.connected:
  //         isConnectedToInternet.value = true;
  //         break;
  //       case InternetStatus.disconnected:
  //         isConnectedToInternet.value = false;
  //         break;
  //       default:
  //         isConnectedToInternet.value = false;
  //         break;
  //     }
  //     // print('Internet Status: $isConnectedToInternet');
  //     update();
  //   });
  // }

  @override
  void onClose() {
    internetStreamSubscription?.cancel();
    super.onClose();
  }
}