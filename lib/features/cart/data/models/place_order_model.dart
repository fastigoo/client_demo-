import 'package:client/core/objects/models/customer_location_model.dart';
import 'package:client/core/objects/models/order_status_model.dart';
import 'package:client/features/cart/domain/entities/place_order_entity.dart';

class PlaceOrderModel extends PlaceOrderEntity {
  PlaceOrderModel({
    required super.orderId,
    required super.userId,
    required super.clientId,
    required super.orderStatus,
  });

  factory PlaceOrderModel.fromJson(Map<String, dynamic> json) {
    return PlaceOrderModel(
      orderId: json['order_id'],
      userId: json['user_id'],
      clientId: json['client_id'],
      orderStatus: OrderStatusModel.fromJson(
        json['order_status'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'user_id': userId,
      'client_id': clientId,
      'order_status': orderStatus,
    };
  }
}