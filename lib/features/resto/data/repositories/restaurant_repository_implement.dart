import 'package:dartz/dartz.dart';
import 'package:learning/core/error/exceptions.dart';
import 'package:learning/core/error/failures.dart';
import 'package:learning/features/resto/data/datasources/restaurant_data_source.dart';
import 'package:learning/features/resto/domain/entities/restaurants_entity.dart';
import 'package:learning/features/resto/domain/repositories/restaurant_repository.dart';

class RestaurantRepositoryImplement implements RestaurantRepository {
  final RestaurantDataSource remote;

  RestaurantRepositoryImplement({required this.remote});

  @override
  Future<Either<Failure, RestaurantsEntity>> getRestaurants({required int page, required int perPage, String name = ""}) async {
    try {
      final restaurants = await remote.getRestaurants(page: page, perPage: perPage, name: name);
      return Right(restaurants);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
