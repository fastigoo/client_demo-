class NormalOrderEntity {
  final int orderId;
  final int orderStatusId;
  final String restaurantName;
  final String orderStatusValue;
  final double deliveryFee;
  final double totalAmount;
  final String? road;
  final String? city;
  final String createdAt;

  NormalOrderEntity({
    required this.orderId,
    required this.orderStatusId,
    required this.restaurantName,
    required this.orderStatusValue,
    required this.deliveryFee,
    required this.totalAmount,
    required this.createdAt,
    this.road,
    this.city,
  });
}