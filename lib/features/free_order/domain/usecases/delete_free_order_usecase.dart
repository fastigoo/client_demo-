import 'package:dartz/dartz.dart';
import 'package:learning/core/error/failures.dart';
import 'package:learning/features/free_order/domain/repositories/free_order_repository.dart';

class DeleteFreeOrderUsecase {
  final FreeOrderRepository repository;

  DeleteFreeOrderUsecase({required this.repository});

  Future<Either<Failure, Unit>> call({required int orderId}) async {
    return await repository.deleteFreeOrders(orderId: orderId);
  }
}