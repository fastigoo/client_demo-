
import 'package:learning/core/objects/entities/order_status_entity.dart';

class FreeOrderItemEntity {
  final int freeOrderId;
  final OrderStatusEntity status;
  final String createdAt;

  FreeOrderItemEntity({
    required this.freeOrderId,
    required this.status,
    required this.createdAt,
  });
}