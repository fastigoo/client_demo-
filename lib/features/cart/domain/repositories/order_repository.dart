import 'package:dartz/dartz.dart';
import 'package:learning/core/error/failures.dart';
import 'package:learning/features/cart/domain/entities/cart_item_entity.dart';
import 'package:learning/features/cart/domain/entities/delivery_fee_entity.dart';
import 'package:learning/features/cart/domain/entities/place_order_entity.dart';

abstract interface class OrderRepository {
  Future<Either<Failure, PlaceOrderEntity>> placeOrder({
    required int restaurantId,
    required String phone,
    required double lat,
    required double long,
    required List<CartItemEntity> cartItems,
  });

  Future<Either<Failure, DeliveryFeeEntity>> calculateDeliveryFee({
    required int restaurantId,
    required double lat,
    required double long,
  });
}