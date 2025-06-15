import 'package:dartz/dartz.dart';
import 'package:client/core/error/failures.dart';
import 'package:client/features/free_order/domain/entities/free_order_item_list_entity.dart';
import 'package:client/features/free_order/domain/repositories/free_order_repository.dart';

class GetFreeOrderDetailUsecase {
  final FreeOrderRepository repository;

  GetFreeOrderDetailUsecase({required this.repository});

  Future<Either<Failure, List<FreeOrderItemListEntity>>> call({required int id}) async {
    return await repository.getFreeOrderList(id: id);
  }
}