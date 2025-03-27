import 'package:dartz/dartz.dart';
import 'package:learning/core/error/failures.dart';
import 'package:learning/features/orders/data/datasources/orders_data_source.dart';
import 'package:learning/features/orders/domain/entities/orders_res_entity.dart';
import 'package:learning/features/orders/domain/repositories/orders_repository.dart';

class OrdersRepositoryImplement implements OrdersRepository {
  final OrdersDataSource ordersDataSource;

  OrdersRepositoryImplement({required this.ordersDataSource});

  @override
  Future<Either<Failure, OrderResEntity>> getOrders({required int userId, required int page, int limit = 10}) async {
    try {
      final orders = await ordersDataSource.getOrders(userId: userId, page: page, limit: limit);
      return Right(orders);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
