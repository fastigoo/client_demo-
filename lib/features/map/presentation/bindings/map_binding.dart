import 'package:learning/features/map/presentation/states/map_state.dart';
import 'package:get/get.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MapState());
  }
}