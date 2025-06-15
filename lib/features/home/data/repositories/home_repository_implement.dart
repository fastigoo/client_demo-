

import 'package:client/core/error/exceptions.dart';
import 'package:client/core/error/failures.dart';
import 'package:client/features/home/data/datasources/home_datasource.dart';
import 'package:client/features/home/domain/entities/item_detail_entity.dart';
import 'package:client/features/home/domain/entities/menu_item_entity.dart';
import 'package:client/features/home/domain/entities/restaurant_menu_entity.dart';
import 'package:client/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class HomeRepositoryImplement implements HomeRepository {
  final HomeDataSource remoteDataSource;

  HomeRepositoryImplement({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<RestaurantMenuEntity>>> getRestaurantMenus({required int restaurantId}) async {
    try {
      final result = await remoteDataSource.getRestaurantMenus(restaurantId: restaurantId);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<MenuItemEntity>>> getRestaurantMenuItems({required int menuId}) async {
    try {
      final result = await remoteDataSource.getRestaurantMenuItems(menuId: menuId);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ItemDetailEntity>> getItemDetail({required int itemId}) async {
    try {
      final result = await remoteDataSource.getItemDetail(itemId: itemId);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}