import 'package:get/get.dart';
import 'package:client/core/helper/utils.dart';
import 'package:client/core/resources/language_strings.dart';
import 'package:client/features/home/domain/entities/menu_item_entity.dart';
import 'package:client/features/home/domain/entities/restaurant_menu_entity.dart';
import 'package:client/features/home/domain/usecases/get_all_restaurant_menus_usecase.dart';
import 'package:client/features/home/domain/usecases/get_restaurant_menu_items_usecase.dart';

class HomeController extends GetxController {
  int? restaurantId;
  String? restaurantName;

  RxBool menuIsLoading = false.obs;
  RxBool itemsIsLoading = false.obs;

  final _getAllRestaurantMenusUseCase = Get.find<GetAllRestaurantMenusUseCase>();
  final _getMenuItemsUseCase = Get.find<GetRestaurantMenuItemsUseCase>();

  List<RestaurantMenuEntity> restaurantMenus = [];
  List<MenuItemEntity> menuItems = [];

  int _selectedMenuId = 0;
  int get selectedMenuId => _selectedMenuId;

  @override
  void onInit() {
    super.onInit();
    restaurantId = Get.arguments['restaurantId'];
    restaurantName = Get.arguments['restaurantName'];
    menuItems.clear();
    getRestaurantMenus();
  }

  void setSelectedMenuId(int menuId) {
    _selectedMenuId = menuId;
    getMenuItems();
  }

  void getRestaurantMenus() async {
    try {
      menuIsLoading.value = true;
      final response = await _getAllRestaurantMenusUseCase.execute(restaurantId: restaurantId!);
      response.fold(
        (l) {},
        (List<RestaurantMenuEntity> menus) {
          restaurantMenus.addAll(menus);
          _selectedMenuId = restaurantMenus.first.menuId;
          getMenuItems();
        },
      );
    } finally {
      menuIsLoading.value = false;
    }
  }

  void getMenuItems() async {
    try {
      itemsIsLoading.value = true;
      final response = await _getMenuItemsUseCase.execute(menuId: selectedMenuId);
      response.fold(
        (l) {},
        (List<MenuItemEntity> menus) {
          menuItems.clear();
          menuItems.addAll(menus);
        },
      );
    } catch (e) {
      showToast(message: LanguageStrings.somethingWentWrong);
    } finally {
      itemsIsLoading.value = false;
    }
  }
}
