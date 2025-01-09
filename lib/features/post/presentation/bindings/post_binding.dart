

import 'package:get/get.dart';
import 'package:learning/features/post/presentation/states/post_controller.dart';

class PostBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PostController(), permanent: true);
  }
}