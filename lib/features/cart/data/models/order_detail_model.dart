import 'package:client/core/objects/models/customer_location_model.dart';
import 'package:client/core/objects/models/order_restaurant_model.dart';
import 'package:client/core/objects/models/order_status_model.dart';
import 'package:client/features/cart/domain/entities/order_detail_entity.dart';

class OrderDetailModel extends OrderDetailEntity {
  OrderDetailModel({
    required super.orderId,
    required super.restaurant,
    required super.orderStatus,
    required super.amount,
    required super.customerLocation,
    required super.createdAt,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      orderId: json['order_id'],
      restaurant: OrderRestaurantModel.fromJson(
        json['restaurant'],
      ),
      orderStatus: OrderStatusModel.fromJson(
        json['order_status'],
      ),
      amount: AmountModel.fromJson(
        json['amount'],
      ),
      customerLocation: OrderCustomerLocationModel.fromJson(
        json['customer_location'],
      ),
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'restaurant': restaurant,
      'order_status': orderStatus,
      'amount': amount,
      'customer_location': customerLocation,
      'created_at': createdAt,
    };
  }
}

class AmountModel extends AmountEntity {
  AmountModel({
    required super.currency,
    required super.deliveryFee,
    required super.totalAmount,
  });

  factory AmountModel.fromJson(Map<String, dynamic> json) {
    return AmountModel(
      currency: json['currency'],
      deliveryFee: json['delivery_fee'],
      totalAmount: json['total_amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currency': currency,
      'delivery_fee': deliveryFee,
      'total_amount': totalAmount,
    };
  }
}
