import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning/core/objects/entities/customer_location_entity.dart';

class FreeOrderController extends GetxController {
  final phoneController = TextEditingController(text: "0");

  // Add new item
  final nameController = TextEditingController();
  final quantityController = TextEditingController(text: "1");
  RxString selectedUnite = "Kg".obs;
  List<String> unites = ["Kg", "Litre", "Metre", "Unit"];

  List<FreeOrderItemModel> items = [];

  OrderCustomerLocationEntity? address;

  void addQuantity() {
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
    items.add(FreeOrderItemModel(
      name: nameController.text,
      quantity: quantityController.text,
      unite: selectedUnite.value,
    ));
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
}

class FreeOrderItemModel {
  final String name;
  final String quantity;
  final String unite;

  FreeOrderItemModel({required this.name, required this.quantity, required this.unite});
}
