import 'package:learning/features/orders/data/models/normal_order_model.dart';
import 'package:learning/features/orders/domain/entities/orders_res_entity.dart';

class OrderResModel extends OrderResEntity {
  OrderResModel({
    required super.totalOrders,
    required super.orders,
  });

  factory OrderResModel.fromJson(Map<String, dynamic> json) {
    return OrderResModel(
      totalOrders: json['total_orders'],
      orders: (json['orders'] as List).map((e) => NormalOrderModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_orders': super.totalOrders,
      'orders': super.orders,
    };
  }
}
