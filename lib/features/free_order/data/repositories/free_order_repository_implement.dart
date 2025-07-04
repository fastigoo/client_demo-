import 'package:client/core/error/exceptions.dart';
import 'package:client/core/error/failures.dart';
import 'package:client/features/free_order/data/datasources/free_order_datasource.dart';
import 'package:client/features/free_order/domain/entities/add_free_order_res_entity.dart';
import 'package:client/features/free_order/domain/entities/free_order_item_list_entity.dart';
import 'package:client/features/free_order/domain/entities/free_order_res_entity.dart';
import 'package:client/features/free_order/domain/repositories/free_order_repository.dart';
import 'package:client/features/free_order/presentation/states/free_order_controller.dart';
import 'package:dartz/dartz.dart';

class FreeOrderRepositoryImplement implements FreeOrderRepository {
  final FreeOrderDatasource remoteDataSource;

  FreeOrderRepositoryImplement({required this.remoteDataSource});

  @override
  Future<Either<Failure, FreeOrderResEntity>> getFreeOrders({required int userId, required int page, int limit = 10}) async {
    try {
      final result = await remoteDataSource.getFreeOrders(userId: userId, page: page, limit: limit);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<FreeOrderItemListEntity>>> getFreeOrderList({required int id}) async {
    try {
      final result = await remoteDataSource.getFreeOrderList(id: id);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, AddFreeOrderResEntity>> addFreeOrder({
    required String phone,
    required double latitude,
    required double longitude,
    required String fcm,
    required List<FreeOrderItemModel> items,
  }) async {
    try {
      final result = await remoteDataSource.addFreeOrder(
        phone: phone,
        latitude: latitude,
        longitude: longitude,
        fcm: fcm,
        items: items,
      );
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteFreeOrders({required int orderId}) async {
    try {
      final result = await remoteDataSource.deleteFreeOrders(orderId: orderId);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
