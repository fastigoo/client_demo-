import 'package:dartz/dartz.dart';
import 'package:client/core/error/failures.dart';
import 'package:client/features/cart/domain/repositories/order_repository.dart';

class DeleteOrderUseCase {
  final OrderRepository repository;

  DeleteOrderUseCase({required this.repository});

  Future<Either<Failure, String>> execute({
    required int orderId,
  }) async {
    return await repository.deleteOrder(orderId: orderId);
  }
}
