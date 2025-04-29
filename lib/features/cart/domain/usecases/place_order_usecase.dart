

import 'package:dartz/dartz.dart';
import 'package:learning/core/error/failures.dart';
import 'package:learning/features/cart/domain/entities/cart_item_entity.dart';
import 'package:learning/features/cart/domain/entities/place_order_entity.dart';
import 'package:learning/features/cart/domain/repositories/order_repository.dart';

class PlaceOrderUseCase {
  final OrderRepository repository;

  PlaceOrderUseCase({required this.repository});

  Future<Either<Failure, PlaceOrderEntity>> execute({
    required int restaurantId,
    required String phone,
    required double lat,
    required double long,
    required List<CartItemEntity> cartItems,
    required int deliveryFee,
    required double distance,
    String? fcm,
  }) async {
    return await repository.placeOrder(
      restaurantId: restaurantId,
      phone: phone,
      lat: lat,
      long: long,
      cartItems: cartItems,
      deliveryFee: deliveryFee,
      distance: distance,
      fcm: '',
    );
  }
}