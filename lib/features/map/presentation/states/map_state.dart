import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:learning/core/helper/utils.dart';
import 'package:learning/core/objects/entities/customer_location_entity.dart';
import 'package:learning/features/map/domain/usecases/get_address_from_latlng_usecase.dart';
import 'package:learning/features/resto/presentation/states/free_order_controller.dart';

class MapState extends GetxController {
  final isMapReady = false.obs;
  final isLocationEnable = true.obs;

  final _serviceEnabled = false.obs;

  bool get serviceEnabled => _serviceEnabled.value;
  Position? currentPos;
  LatLng? orderPos;
  LocationPermission _permission = LocationPermission.denied;

  final mapController = MapController();

  final isLoadingAddress = false.obs;
  final _getAddressesUseCase = Get.find<GetAddressFromLatLngUseCase>();
  OrderCustomerLocationEntity? address;

  @override
  void onInit() {
    getCurrentLocation();
    super.onInit();
  }

  Future<void> getCurrentLocation() async {
    isMapReady.value = false;
    _serviceEnabled.value = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled.value) {
      isMapReady.value = true;
      Get.snackbar(
        'Location Service Disabled',
        'Please enable location services to use this feature.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
      if (_permission == LocationPermission.denied) {
        Get.snackbar(
          'Location Permission Denied',
          'Please grant location permission to use this feature.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      if (_permission == LocationPermission.deniedForever) {
        Get.snackbar(
          'Location Permission Denied Forever',
          'Please enable location permission in the app settings.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
    }

    try {
      currentPos = await Geolocator.getCurrentPosition();
      goToCurrentLocation();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Unable to get current location: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isMapReady.value = true;
    }
  }

  Future<void> enableLocationAgain() async {
    isMapReady.value = false;
    _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
      if (_permission == LocationPermission.denied) {
        Get.snackbar(
          'Location Permission Denied',
          'Please grant location permission to use this feature.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      if (_permission == LocationPermission.deniedForever) {
        Get.snackbar(
          'Location Permission Denied Forever',
          'Please enable location permission in the app settings.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
    }

    try {
      currentPos = await Geolocator.getCurrentPosition();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Unable to get current location: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isMapReady.value = true;
    }
  }

  void goToCurrentLocation() {
    if (currentPos != null) {
      Future.delayed(const Duration(milliseconds: 100), () {
        mapController.move(LatLng(currentPos!.latitude, currentPos!.longitude), 15);
        getAddressFromLatLng();
      });
    } else {
      Get.snackbar(
        'Error',
        'Current location is not available.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> getAddressFromLatLng() async {
    try {
      isLoadingAddress.value = true;
      final response = await _getAddressesUseCase.call(latLng: getMarkerPosition());
      response.fold(
        (l) {
          showToast(message: l.toString());
        },
        (OrderCustomerLocationEntity address) {
          this.address = address;
          Get.find<FreeOrderController>().updateAddress(address);
        },
      );
    } catch (e) {
      showToast(message: 'Error: $e');
    } finally {
      isLoadingAddress.value = false;
    }
  }

  void setOrderPos(LatLng point) async {
    orderPos = point;
    mapController.move(point, 15);
    update();
  }
  LatLng getMarkerPosition() {
    final result = orderPos ?? LatLng(currentPos!.latitude, currentPos!.longitude);
    return result;
  }
}
