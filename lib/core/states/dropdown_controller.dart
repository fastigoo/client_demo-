
import 'package:get/get.dart';

class DropdownController extends GetxController {
  final RxBool isDropdownOpen = false.obs;
  final RxString selectedValue = ''.obs;
  final RxList<String> items = <String>[].obs;

  void toggleDropdown() {
    isDropdownOpen.value = !isDropdownOpen.value;
  }

  void selectItem(String value) {
    selectedValue.value = value;
    isDropdownOpen.value = false;
  }

  void setItems(List<String> items) {
    this.items.value = items;
  }
}