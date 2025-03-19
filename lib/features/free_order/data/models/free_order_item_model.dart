import 'package:learning/core/objects/models/order_status_model.dart';
import 'package:learning/features/free_order/domain/entities/free_order_item_entity.dart';

class FreeOrderItemModel extends FreeOrderItemEntity {
  FreeOrderItemModel({
    required super.freeOrderId,
    required super.status,
    required super.createdAt,
  });

  factory FreeOrderItemModel.fromJson(Map<String, dynamic> json) {
    return FreeOrderItemModel(
      freeOrderId: json['free_order_id'],
      status: OrderStatusModel.fromJson(json['status']),
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'free_order_id': freeOrderId,
      'status': status,
      'created_at': createdAt,
    };
  }
}
