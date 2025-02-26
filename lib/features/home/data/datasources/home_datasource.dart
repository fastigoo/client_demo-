import 'package:dio/dio.dart';
import 'package:learning/core/resources/apis.dart';
import 'package:learning/features/home/data/models/item_detail_model.dart';
import 'package:learning/features/home/data/models/menu_item_model.dart';
import 'package:learning/features/home/data/models/restaurant_menu_model.dart';

abstract interface class HomeDataSource {
  Future<List<RestaurantMenuModel>> getRestaurantMenus({required int restaurantId});
  Future<List<MenuItemModel>> getRestaurantMenuItems({required int menuId});
  Future<ItemDetailModel> getItemDetail({required int itemId});
}

class HomeDataSourceImplement implements HomeDataSource {
  @override
  Future<List<RestaurantMenuModel>> getRestaurantMenus({required int restaurantId}) async {
    try {
      Dio dio = Dio();
      Response response = await dio.get(
        '$allRestaurantMenuUrl/$restaurantId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      List<RestaurantMenuModel> menus = [];
      for (var item in response.data) {
        menus.add(RestaurantMenuModel.fromJson(item));
      }
      return menus;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<MenuItemModel>> getRestaurantMenuItems({required int menuId}) async {
    try {
      Dio dio = Dio();
      Response response = await dio.get(
        '$allRestaurantMenuItemsUrl/$menuId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      List<MenuItemModel> items = [];
      for (var item in response.data) {
        items.add(MenuItemModel.fromJson(item));
      }
      return items;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ItemDetailModel> getItemDetail({required int itemId})  async {
    try {
      Dio dio = Dio();
      Response response = await dio.get(
        '$itemDetailUrl/$itemId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      return ItemDetailModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
