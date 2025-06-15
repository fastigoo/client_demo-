import 'package:dartz/dartz.dart';
import 'package:client/core/error/failures.dart';
import 'package:client/features/cart/domain/entities/cart_item_entity.dart';
import 'package:client/features/cart/domain/entities/delivery_fee_entity.dart';
import 'package:client/features/cart/domain/entities/order_detail_entity.dart';
import 'package:client/features/cart/domain/entities/place_order_entity.dart';
import 'package:client/features/orders/domain/entities/orders_res_entity.dart';

abstract interface class OrderRepository {
  Future<Either<Failure, PlaceOrderEntity>> placeOrder({
    required int restaurantId,
    required String phone,
    required double lat,
    required double long,
    required List<CartItemEntity> cartItems,
    required int deliveryFee,
    required double distance,
    required String fcm,
  });

  Future<Either<Failure, DeliveryFeeEntity>> calculateDeliveryFee({
    required int restaurantId,
    required double lat,
    required double long,
  });

  Future<Either<Failure, OrderDetailEntity>> getOrderDetail({
    required int orderId,
  });

  Future<Either<Failure, OrderResEntity>> getOrders({
    required int userId,
    required int page,
    int limit = 10,
  });

  Future<Either<Failure, String>> deleteOrder({
    required int orderId,
  });
}
