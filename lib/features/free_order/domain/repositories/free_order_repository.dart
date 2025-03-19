import 'package:dartz/dartz.dart';
import 'package:learning/core/error/failures.dart';
import 'package:learning/features/free_order/domain/entities/free_order_item_list_entity.dart';
import 'package:learning/features/free_order/domain/entities/free_order_res_entity.dart';
import 'package:learning/features/free_order/presentation/states/free_order_controller.dart';

abstract interface class FreeOrderRepository {
  Future<Either<Failure, FreeOrderResEntity>> getFreeOrders({required int page, int limit = 10});
  Future<Either<Failure, List<FreeOrderItemListEntity>>> getFreeOrderList({required int id});
  Future<Either<Failure, String>> addFreeOrder({
    required String phone,
    required double latitude,
    required double longitude,
    required String fcm,
    required List<FreeOrderItemModel> items,
  });
}