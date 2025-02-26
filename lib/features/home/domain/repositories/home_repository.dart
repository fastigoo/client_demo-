import 'package:dartz/dartz.dart';
import 'package:learning/core/error/failures.dart';
import 'package:learning/features/home/domain/entities/item_detail_entity.dart';
import 'package:learning/features/home/domain/entities/menu_item_entity.dart';
import 'package:learning/features/home/domain/entities/restaurant_menu_entity.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, List<RestaurantMenuEntity>>> getRestaurantMenus({required int restaurantId});
  Future<Either<Failure, List<MenuItemEntity>>> getRestaurantMenuItems({required int menuId});
  Future<Either<Failure, ItemDetailEntity>> getItemDetail({required int itemId});
}