
import 'package:dartz/dartz.dart';
import 'package:learning/core/error/failures.dart';
import 'package:learning/features/home/domain/entities/restaurant_menu_entity.dart';
import 'package:learning/features/home/domain/repositories/home_repository.dart';

class GetAllRestaurantMenusUseCase {
  final HomeRepository repository;

  GetAllRestaurantMenusUseCase({required this.repository});

  Future<Either<Failure, List<RestaurantMenuEntity>>> execute({required int restaurantId}) {
    return repository.getRestaurantMenus(restaurantId: restaurantId);
  }
}