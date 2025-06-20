import 'package:dartz/dartz.dart';
import 'package:client/core/error/failures.dart';
import 'package:client/features/orders/domain/entities/orders_res_entity.dart';
import 'package:client/features/orders/domain/repositories/orders_repository.dart';

class AllOrdersUseCase {
  final OrdersRepository ordersRepository;

  AllOrdersUseCase({required this.ordersRepository});

  Future<Either<Failure, OrderResEntity>> call({required int userId, required int page, limit = 10}) async {
    return await ordersRepository.getOrders(userId: userId, page: page, limit: limit);
  }
}
