class FreeOrderItemEntity {
  final int freeOrderId;
  final int orderStatusId;
  final String orderStatusValue;
  final String? road;
  final String? city;
  final String createdAt;

  FreeOrderItemEntity({
    required this.freeOrderId,
    required this.orderStatusId,
    required this.orderStatusValue,
    required this.createdAt,
    this.road,
    this.city,
  });
}
