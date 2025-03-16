import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FreeOrderController extends GetxController {
  final phoneController = TextEditingController(text: "0");

  // Add new item
  final nameController = TextEditingController();
  final quantityController = TextEditingController(text: "1");
  RxString selectedUnite = "Kg".obs;
  List<String> unites = ["Kg", "Litre", "Metre" "Unit"];

  RxBool isLoading = false.obs;

  void addQuantity() {
    quantityController.text = (int.parse(quantityController.text) + 1).toString();
  }

  void removeQuantity() {
    if (int.parse(quantityController.text) > 1) {
      quantityController.text = (int.parse(quantityController.text) - 1).toString();
    }
  }

  void reset() {
    nameController.clear();
    quantityController.text = "1";
    selectedUnite.value = "Kg";
  }
}
