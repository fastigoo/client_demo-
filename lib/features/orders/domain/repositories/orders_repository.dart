import 'package:dartz/dartz.dart';
import 'package:client/core/error/failures.dart';
import 'package:client/features/orders/domain/entities/orders_res_entity.dart';

abstract interface class OrdersRepository {
  Future<Either<Failure, OrderResEntity>> getOrders({required int userId, required int page, int limit = 10});
  // Future<Either<Failure, String>> deleteOrder({required int orderId});
}
