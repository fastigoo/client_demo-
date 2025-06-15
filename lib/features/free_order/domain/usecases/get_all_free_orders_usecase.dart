import 'package:dartz/dartz.dart';
import 'package:client/core/error/failures.dart';
import 'package:client/features/free_order/domain/entities/free_order_res_entity.dart';
import 'package:client/features/free_order/domain/repositories/free_order_repository.dart';

class GetAllFreeOrdersUsecase {
  final FreeOrderRepository repository;

  GetAllFreeOrdersUsecase({required this.repository});

  Future<Either<Failure, FreeOrderResEntity>> call({required int userId, required int page, int limit = 10}) async {
    return await repository.getFreeOrders(page: page, limit: limit, userId: userId);
  }
}