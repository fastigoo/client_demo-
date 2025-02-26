import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MapStreetController extends GetxController {
  RxBool isMapReady = false.obs;

  bool _serviceEnabled = false;
  LocationPermission _permission = LocationPermission.denied;
  Position? currentPos;
  //
  // Rx<LatLng> selectedPosition = Rx<LatLng>(const LatLng(0, 0));
  // void onMapTap(LatLng? latLng) {
  //   if (latLng != null) {
  //     selectedPosition.value = latLng;
  //   }
  // }
  //
  // void onMapCreated(GoogleMapController controller) {
  //   _controller = controller;
  // }

  // @override
  // void onInit() {
  //   super.onInit();
  //   getCurrentLocation();
  // }

  Future<Position> getCurrentLocation() async {
    isMapReady.value = false;
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      return Future.error('Location service disabled');
    }
    _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
      if (_permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
      if (_permission == LocationPermission.deniedForever) {
        return Future.error('Location permission denied forever');
      }
    }
    currentPos = await Geolocator.getCurrentPosition();
    isMapReady.value = true;
    return currentPos!;
  }

  // void updateToCurrentPosition() {
  //   _controller.animateCamera(
  //     CameraUpdate.newCameraPosition(
  //       CameraPosition(
  //         target: LatLng(currentPos!.latitude, currentPos!.longitude),
  //         zoom: 15.0,
  //       ),
  //     ),
  //   );
  // }
}
