import 'package:dartz/dartz.dart';
import 'package:client/core/error/failures.dart';
import 'package:client/features/home/domain/entities/item_detail_entity.dart';
import 'package:client/features/home/domain/entities/menu_item_entity.dart';
import 'package:client/features/home/domain/entities/restaurant_menu_entity.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, List<RestaurantMenuEntity>>> getRestaurantMenus({required int restaurantId});
  Future<Either<Failure, List<MenuItemEntity>>> getRestaurantMenuItems({required int menuId});
  Future<Either<Failure, ItemDetailEntity>> getItemDetail({required int itemId});
}