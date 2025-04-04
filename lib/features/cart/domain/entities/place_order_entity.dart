import 'package:learning/core/objects/entities/customer_location_entity.dart';
import 'package:learning/core/objects/entities/order_status_entity.dart';

class PlaceOrderEntity {
  final int orderId;
  final int userId;
  final OrderStatusEntity orderStatus;
  final OrderCustomerLocationEntity orderCustomerLocation;

  PlaceOrderEntity({
    required this.orderId,
    required this.userId,
    required this.orderStatus,
    required this.orderCustomerLocation,
  });
}
