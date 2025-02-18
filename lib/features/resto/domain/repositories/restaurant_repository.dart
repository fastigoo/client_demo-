import 'package:dartz/dartz.dart';
import 'package:learning/core/error/failures.dart';
import 'package:learning/features/resto/domain/entities/restaurants_entity.dart';

abstract interface class RestaurantRepository {
  Future<Either<Failure, RestaurantsEntity>> getRestaurants({required int page, required int perPage, String name = ""});
}