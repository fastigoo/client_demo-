import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client/features/splash/presentation/states/splash_controller.dart';
import 'package:client/routes/app_pages.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Get.offNamed(Routes.HOME);
          },
          child: const Text('Splash Screen'),
        ),
      ),
    );
  }
}
