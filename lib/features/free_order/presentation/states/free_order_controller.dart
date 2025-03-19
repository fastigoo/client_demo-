import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning/core/helper/utils.dart';
import 'package:learning/core/objects/entities/customer_location_entity.dart';
import 'package:learning/features/free_order/domain/usecases/add_free_order_usecase.dart';
import 'package:learning/routes/app_pages.dart';

class FreeOrderController extends GetxController {
  RxBool isLoading = false.obs;

  final phoneController = TextEditingController(text: "0");

  final _addFreeOrderUsecase = Get.find<AddFreeOrderUsecase>();
  final formKey = GlobalKey<FormState>();
  final itemFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final quantityController = TextEditingController(text: "1");
  RxString selectedUnite = "Kg".obs;
  List<String> unites = ["Kg", "Litre", "Metre", "Unit"];

  List<FreeOrderItemModel> items = [];

  OrderCustomerLocationEntity? address;

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
    selectedUnite.value = "Kg";
  }

  void updateAddress(OrderCustomerLocationEntity address) {
    this.address = address;
    update();
  }

  void addFreeOrder() async {
    try {
      isLoading.value = true;
      var response = await _addFreeOrderUsecase.call(
        phone: phoneController.text,
        latitude: 36.46545645,
        longitude: 6.4435435,
        fcm: "fcm_token",
        items: items,
      );
      response.fold(
        (l) {
          showToast(message: "Error: $l");
        },
        (String value) {
          showToast(message: value);
          items.clear();
          Get.offAndToNamed(Routes.SUCCESS);
        },
      );
    } catch (e) {
      showToast(message: "Error: $e");
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
