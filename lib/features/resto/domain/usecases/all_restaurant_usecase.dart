import 'package:dartz/dartz.dart';
import 'package:client/core/error/failures.dart';
import 'package:client/features/resto/domain/entities/restaurants_entity.dart';
import 'package:client/features/resto/domain/repositories/restaurant_repository.dart';

class AllRestaurantUsecase {
  final RestaurantRepository repository;

  AllRestaurantUsecase({required this.repository});

  Future<Either<Failure, RestaurantsEntity>> execute({required int page, required int perPage, String name = ""}) async {
    return await repository.getRestaurants(page: page, perPage: perPage, name: name);
  }
}
