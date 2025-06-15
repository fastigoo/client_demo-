import 'package:client/features/free_order/data/models/free_order_item_model.dart';
import 'package:client/features/free_order/domain/entities/free_order_res_entity.dart';

class FreeOrderResModel extends FreeOrderResEntity {
  FreeOrderResModel({
    required super.totalOrders,
    required super.orders,
  });

  factory FreeOrderResModel.fromJson(Map<String, dynamic> json) {
    return FreeOrderResModel(
      totalOrders: json['total_orders'],
      orders: List<FreeOrderItemModel>.from(
        json['orders'].map<FreeOrderItemModel>(
          (x) => FreeOrderItemModel.fromJson(x),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_orders': totalOrders,
      'orders': orders,
    };
  }
}
