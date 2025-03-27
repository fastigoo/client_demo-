import 'package:learning/features/orders/domain/entities/normal_order_entity.dart';

class OrderResEntity {
  final int totalOrders;
  final List<NormalOrderEntity> orders;

  OrderResEntity({
    required this.totalOrders,
    required this.orders,
  });
}