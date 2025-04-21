

class DeliveryFeeEntity {
  final String currency;
  final int deliveryFee;
  final double distance;


  DeliveryFeeEntity({
    required this.currency,
    required this.deliveryFee,
    required this.distance,
  });

  double getNormalizedDistance () {
    if (distance >= 1000) {
      return distance / 1000;
    } else {
      return distance;
    }
  }

  bool isNormalizedDistance() {
    return distance >= 1000;
  }
}