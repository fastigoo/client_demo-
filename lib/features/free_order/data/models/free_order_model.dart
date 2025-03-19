import 'package:learning/features/free_order/data/models/free_order_item_model.dart';
import 'package:learning/features/free_order/domain/entities/free_order_res_entity.dart';

class FreeOrderResModel extends FreeOrderResEntity {
  FreeOrderResModel({
    required super.itemsCount,
    required super.orders,
  });

  factory FreeOrderResModel.fromJson(Map<String, dynamic> json) {
    return FreeOrderResModel(
      itemsCount: json['items_count'],
      orders: List<FreeOrderItemModel>.from(
        json['orders'].map<FreeOrderItemModel>(
          (x) => FreeOrderItemModel.fromJson(x),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items_count': itemsCount,
      'orders': orders,
    };
  }
}
