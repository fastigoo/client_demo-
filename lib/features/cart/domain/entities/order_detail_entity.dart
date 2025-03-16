import 'package:learning/core/objects/entities/customer_location_entity.dart';
import 'package:learning/core/objects/entities/order_restaurant_entity.dart';
import 'package:learning/core/objects/entities/order_status_entity.dart';

class OrderDetailEntity {

  final int orderId;
  final OrderRestaurantEntity restaurant;
  final OrderStatusEntity orderStatus;
  final AmountEntity amount;
  final OrderCustomerLocationEntity customerLocation;
  final String createdAt;

  OrderDetailEntity({
    required this.orderId,
    required this.restaurant,
    required this.orderStatus,
    required this.amount,
    required this.customerLocation,
    required this.createdAt,
  });
}

class AmountEntity {
  final String currency;
  final double deliveryFee;
  final double totalAmount;

  AmountEntity({
    required this.currency,
    required this.deliveryFee,
    required this.totalAmount,
  });
}