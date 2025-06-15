import 'package:dartz/dartz.dart';
import 'package:client/core/error/failures.dart';
import 'package:client/features/free_order/domain/entities/add_free_order_res_entity.dart';
import 'package:client/features/free_order/domain/entities/free_order_item_list_entity.dart';
import 'package:client/features/free_order/domain/entities/free_order_res_entity.dart';
import 'package:client/features/free_order/presentation/states/free_order_controller.dart';

abstract interface class FreeOrderRepository {
  Future<Either<Failure, FreeOrderResEntity>> getFreeOrders({required int userId, required int page, int limit = 10});
  Future<Either<Failure, Unit>> deleteFreeOrders({required int orderId});
  Future<Either<Failure, List<FreeOrderItemListEntity>>> getFreeOrderList({required int id});
  Future<Either<Failure, AddFreeOrderResEntity>> addFreeOrder({
    required String phone,
    required double latitude,
    required double longitude,
    required String fcm,
    required List<FreeOrderItemModel> items,
  });
}