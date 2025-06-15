import 'package:client/features/free_order/domain/entities/free_order_item_list_entity.dart';

class FreeOrderItemListModel extends FreeOrderItemListEntity {
  FreeOrderItemListModel({
    required super.freeOrderItemId,
    required super.name,
    required super.quantity,
    required super.unit,
  });

  factory FreeOrderItemListModel.fromJson(Map<String, dynamic> json) {
    return FreeOrderItemListModel(
      freeOrderItemId: json['free_order_item_id'],
      name: json['item_name'],
      quantity: json['quantity'],
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'free_order_item_id': freeOrderItemId,
      'item_name': name,
      'quantity': quantity,
      'unit': unit,
    };
  }
}
