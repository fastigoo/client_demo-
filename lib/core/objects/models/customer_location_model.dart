import 'package:learning/core/objects/entities/customer_location_entity.dart';

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
