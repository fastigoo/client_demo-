import 'package:client/features/cart/domain/entities/delivery_fee_entity.dart';

class DeliveryFeeModel extends DeliveryFeeEntity {
  DeliveryFeeModel({
    required super.currency,
    required super.deliveryFee,
    required super.distance,
  });

  factory DeliveryFeeModel.fromJson(Map<String, dynamic> json) {
    return DeliveryFeeModel(
      currency: json['currency'],
      deliveryFee: json['delivery_fee'],
      distance: json['distance'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currency': currency,
      'delivery_fee': deliveryFee,
      'distance': distance,
    };
  }
}
