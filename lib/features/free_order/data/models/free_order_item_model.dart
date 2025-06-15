import 'package:client/features/free_order/domain/entities/free_order_item_entity.dart';

class FreeOrderItemModel extends FreeOrderItemEntity {
  FreeOrderItemModel({
    required super.freeOrderId,
    required super.orderStatusId,
    required super.orderStatusValue,
    required super.createdAt,
    super.road,
    super.city,
  });

  factory FreeOrderItemModel.fromJson(Map<String, dynamic> json) {
    return FreeOrderItemModel(
      freeOrderId: json['free_order_id'],
      orderStatusId: json['order_status_id'],
      orderStatusValue: json['order_status_value'],
      createdAt: json['created_at'],
      road: json['road'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'free_order_id': freeOrderId,
      'order_status_id': orderStatusId,
      'order_status_value': orderStatusValue,
      'created_at': createdAt,
      'road': road,
      'city': city,
    };
  }
}
