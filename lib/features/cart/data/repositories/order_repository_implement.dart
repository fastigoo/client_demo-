import 'package:dartz/dartz.dart';
import 'package:learning/core/error/failures.dart';
import 'package:learning/features/cart/data/datasources/order_data_source.dart';
import 'package:learning/features/cart/domain/entities/cart_item_entity.dart';
import 'package:learning/features/cart/domain/entities/delivery_fee_entity.dart';
import 'package:learning/features/cart/domain/entities/place_order_entity.dart';
import 'package:learning/features/cart/domain/repositories/order_repository.dart';

class OrderRepositoryImplement implements OrderRepository {
  final OrderDataSource orderDataSource;

  OrderRepositoryImplement({required this.orderDataSource});

  @override
  Future<Either<Failure, PlaceOrderEntity>> placeOrder({
    required int restaurantId,
    required String phone,
    required double lat,
    required double long,
    required List<CartItemEntity> cartItems,
  }) async {
    try {
      final result = await orderDataSource.placeOrder(
        restaurantId: restaurantId,
        phone: phone,
        lat: lat,
        long: long,
        cartItems: cartItems,
      );
      return Right(result);
    } on Exception {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, DeliveryFeeEntity>> calculateDeliveryFee({
    required int restaurantId,
    required double lat,
    required double long,
  }) async {
    try {
      final result = await orderDataSource.calculateDeliveryFee(
        restaurantId: restaurantId,
        lat: lat,
        long: long,
      );
      return Right(result);
    } on Exception {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
