import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:learning/core/helper/utils.dart';
import 'package:learning/core/objects/entities/customer_location_entity.dart';
import 'package:learning/core/resources/language_strings.dart';
import 'package:learning/core/resources/storage_keys.dart';
import 'package:learning/core/services/storage_manager.dart';
import 'package:learning/features/free_order/domain/entities/add_free_order_res_entity.dart';
import 'package:learning/features/free_order/domain/usecases/add_free_order_usecase.dart';
import 'package:learning/features/map/presentation/screens/map_screen.dart';
import 'package:learning/features/map/presentation/states/map_state.dart';
import 'package:learning/routes/app_pages.dart';

class FreeOrderController extends GetxController {
  RxBool isLoading = false.obs;

  final phoneController = TextEditingController(text: "0");

  final _addFreeOrderUsecase = Get.find<AddFreeOrderUsecase>();
  final formKey = GlobalKey<FormState>();
  final itemFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final quantityController = TextEditingController(text: "1");
  List<String> unites = [LanguageStrings.kg, LanguageStrings.litter, LanguageStrings.meter, LanguageStrings.unit];
  RxString selectedUnite = "".obs;

  List<FreeOrderItemModel> items = [];

  OrderCustomerLocationEntity? address;
  double lat = 0.0;
  double long = 0.0;

  @override
  void onInit() {
    selectedUnite.value = unites[0];
    phoneController.text = StorageManager.instance.getStringValue(key: StorageKey.userPhoneKey) ?? "0";
    super.onInit();
  }

  void addQuantity() {
    if (quantityController.text.isEmpty) quantityController.text = "1";
    quantityController.text = (int.parse(quantityController.text) + 1).toString();
  }

  void removeQuantity() {
    if (int.parse(quantityController.text) > 1) {
      quantityController.text = (int.parse(quantityController.text) - 1).toString();
    }
  }

  void setSelectedUnit(String value) {
    selectedUnite.value = value;
  }

  void addItem() {
    items.add(
      FreeOrderItemModel(
        name: nameController.text,
        quantity: quantityController.text,
        unite: selectedUnite.value,
      ),
    );
    reset();
    Get.back();
    update();
  }

  void removeItem(int index) {
    items.removeAt(index);
    update();
  }

  void reset() {
    nameController.clear();
    quantityController.text = "1";
    selectedUnite.value = unites[0];
  }

  void updateAddress({required OrderCustomerLocationEntity address, required LatLng pos}) {
    this.address = address;
    lat = pos.latitude;
    long = pos.longitude;
    update();
  }

  void addFreeOrder() async {
    try {
      isLoading.value = true;
      if (lat == 0.0 || long == 0.0) {
        Get.toNamed(Routes.MAP);
        return;
      }
      var response = await _addFreeOrderUsecase.call(
        phone: phoneController.text,
        latitude: lat,
        longitude: long,
        fcm: StorageManager.instance.getFcmToken() ?? "",
        items: items,
      );
      response.fold(
        (l) {
          showToast(message: "${LanguageStrings.error}: $l");
        },
        (AddFreeOrderResEntity res) {
          StorageManager.instance.setInt(key: StorageKey.userIdKey, value: res.userId);
          StorageManager.instance.setString(key: StorageKey.userPhoneKey, value: phoneController.text);
          items.clear();
          Get.offAndToNamed(Routes.SUCCESS);
        },
      );
    } catch (e) {
      showToast(message: "${LanguageStrings.error}: $e");
    } finally {
      isLoading.value = false;
    }
  }
}

class FreeOrderItemModel {
  final String name;
  final String quantity;
  final String unite;

  FreeOrderItemModel({required this.name, required this.quantity, required this.unite});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "quantity": quantity,
      "unit": unite,
    };
  }
}
