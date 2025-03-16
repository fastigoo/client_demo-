import 'package:learning/core/objects/entities/order_status_entity.dart';

class OrderStatusModel extends OrderStatusEntity {
  OrderStatusModel({
    required super.id,
    required super.value,
  });

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) {
    return OrderStatusModel(
      id: json['id'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
    };
  }
}
