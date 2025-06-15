import 'package:client/core/objects/entities/customer_location_entity.dart';
import 'package:client/core/objects/entities/order_status_entity.dart';

class PlaceOrderEntity {
  final int orderId;
  final int userId;
  final int clientId;
  final OrderStatusEntity orderStatus;

  PlaceOrderEntity({
    required this.orderId,
    required this.userId,
    required this.clientId,
    required this.orderStatus,
  });
}
