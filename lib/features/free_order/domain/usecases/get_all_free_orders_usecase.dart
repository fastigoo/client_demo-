import 'package:dartz/dartz.dart';
import 'package:learning/core/error/failures.dart';
import 'package:learning/features/free_order/domain/entities/free_order_res_entity.dart';
import 'package:learning/features/free_order/domain/repositories/free_order_repository.dart';

class GetAllFreeOrdersUsecase {
  final FreeOrderRepository repository;

  GetAllFreeOrdersUsecase({required this.repository});

  Future<Either<Failure, FreeOrderResEntity>> call({required int page, int limit = 10}) async {
    return await repository.getFreeOrders(page: page, limit: limit);
  }
}