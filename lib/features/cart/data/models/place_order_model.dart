import 'package:learning/features/cart/domain/entities/place_order_entity.dart';

class PlaceOrderModel extends PlaceOrderEntity {
  PlaceOrderModel({
    required super.orderId,
    required super.orderDistance,
    required super.currency,
    required super.deliveryFee,
    required super.orderCustomerLocation,
  });

  factory PlaceOrderModel.fromJson(Map<String, dynamic> json) {
    return PlaceOrderModel(
      orderId: json['order_id'],
      orderDistance: OrderDistanceModel.fromJson(
        json['distance'],
      ),
      currency: json['currency'],
      deliveryFee: json['delivery_fee'],
      orderCustomerLocation: OrderCustomerLocationModel.fromJson(
        json['customer_location'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'distance': orderDistance,
      'currency': currency,
      'delivery_fee': deliveryFee,
      'customer_location': orderCustomerLocation,
    };
  }
}

class OrderDistanceModel extends OrderDistanceEntity {
  OrderDistanceModel({
    required super.distance,
    required super.duration,
  });

  factory OrderDistanceModel.fromJson(Map<String, dynamic> json) {
    return OrderDistanceModel(
      distance: json['distance'],
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'distance': distance,
      'duration': duration,
    };
  }
}

class OrderCustomerLocationModel extends OrderCustomerLocationEntity {
  OrderCustomerLocationModel({
    required super.road,
    required super.city,
    required super.country,
    required super.postalCode,
  });

  factory OrderCustomerLocationModel.fromJson(Map<String, dynamic> json) {
    return OrderCustomerLocationModel(
      road: json['road'],
      city: json['city'],
      country: json['country'],
      postalCode: json['postcode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'road': road,
      'city': city,
      'country': country,
      'postcode': postalCode,
    };
  }
}
