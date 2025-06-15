
import 'package:dartz/dartz.dart';
import 'package:client/core/error/failures.dart';
import 'package:client/features/home/domain/entities/menu_item_entity.dart';
import 'package:client/features/home/domain/repositories/home_repository.dart';

class GetRestaurantMenuItemsUseCase {
  final HomeRepository repository;

  GetRestaurantMenuItemsUseCase({required this.repository});

  Future<Either<Failure, List<MenuItemEntity>>> execute({required int menuId}) {
    return repository.getRestaurantMenuItems(menuId: menuId);
  }
}