import 'package:learning/features/orders/domain/entities/normal_order_entity.dart';

class NormalOrderModel extends NormalOrderEntity {
  NormalOrderModel({
    required super.orderId,
    required super.orderStatusId,
    required super.restaurantName,
    required super.orderStatusValue,
    required super.deliveryFee,
    required super.totalAmount,
    required super.createdAt,
    super.road,
    super.city,
  });

  factory NormalOrderModel.fromJson(Map<String, dynamic> json) {
    return NormalOrderModel(
      orderId: json['order_id'],
      orderStatusId: json['order_status_id'],
      restaurantName: json['restaurant_name'],
      orderStatusValue: json['order_status_value'],
      deliveryFee: json['delivery_fee'],
      totalAmount: json['total_amount'],
      createdAt: json['created_at'],
      road: json['road'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': super.orderId,
      'order_status_id': super.orderStatusId,
      'restaurant_name': super.restaurantName,
      'order_status_value': super.orderStatusValue,
      'delivery_fee': super.deliveryFee,
      'total_amount': super.totalAmount,
      'created_at': super.createdAt,
      'road': super.road,
      'city': super.city,
    };
  }
}
