

class PlaceOrderEntity {
  final int orderId;
  final OrderDistanceEntity orderDistance;
  final String currency;
  final int deliveryFee;
  final OrderCustomerLocationEntity orderCustomerLocation;

  PlaceOrderEntity({
    required this.orderId,
    required this.orderDistance,
    required this.currency,
    required this.deliveryFee,
    required this.orderCustomerLocation,
  });
}

class OrderDistanceEntity {
  final double distance;
  final double duration;

  OrderDistanceEntity({
    required this.distance,
    required this.duration,
  });
}

class OrderCustomerLocationEntity {
  final String road;
  final String city;
  final String country;
  final String postalCode;

  OrderCustomerLocationEntity({
    required this.road,
    required this.city,
    required this.country,
    required this.postalCode,
  });
}