import 'package:dartz/dartz.dart';
import 'package:learning/core/error/failures.dart';
import 'package:learning/features/cart/domain/repositories/order_repository.dart';
import 'package:learning/features/orders/domain/entities/orders_res_entity.dart';

class AllOrdersUseCase {
  final OrderRepository repository;

  AllOrdersUseCase({required this.repository});

  Future<Either<Failure, OrderResEntity>> execute({
    required int userId,
    required int page,
    int limit = 10,
  }) async {
    return await repository.getOrders(
      userId: userId,
      page: page,
      limit: limit,
    );
  }
}
