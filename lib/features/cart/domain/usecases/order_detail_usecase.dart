import 'package:dartz/dartz.dart';
import 'package:client/core/error/failures.dart';
import 'package:client/features/cart/domain/entities/order_detail_entity.dart';
import 'package:client/features/cart/domain/repositories/order_repository.dart';

class OrderDetailUseCase {
  final OrderRepository repository;

  OrderDetailUseCase({required this.repository});

  Future<Either<Failure, OrderDetailEntity>> execute({
    required int orderId,
  }) async {
    return await repository.getOrderDetail(
      orderId: orderId,
    );
  }
}
