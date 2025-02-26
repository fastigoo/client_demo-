import 'package:dartz/dartz.dart';
import 'package:learning/core/error/failures.dart';
import 'package:learning/features/cart/domain/entities/delivery_fee_entity.dart';
import 'package:learning/features/cart/domain/repositories/order_repository.dart';

class CalculateDeliveryFeeUseCase {
  final OrderRepository repository;

  CalculateDeliveryFeeUseCase({required this.repository});

  Future<Either<Failure, DeliveryFeeEntity>> execute({
    required int restaurantId,
    required double lat,
    required double long,
  }) async {
    return await repository.calculateDeliveryFee(
      restaurantId: restaurantId,
      lat: lat,
      long: long,
    );
  }
}
