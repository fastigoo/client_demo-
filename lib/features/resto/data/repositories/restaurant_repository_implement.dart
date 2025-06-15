import 'package:client/core/error/exceptions.dart';
import 'package:client/core/error/failures.dart';
import 'package:client/features/resto/data/datasources/restaurant_data_source.dart';
import 'package:client/features/resto/domain/entities/restaurants_entity.dart';
import 'package:client/features/resto/domain/repositories/restaurant_repository.dart';
import 'package:dartz/dartz.dart';

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
