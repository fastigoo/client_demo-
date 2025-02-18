import 'package:learning/features/resto/domain/entities/restaurant_entity.dart';

class RestaurantModel extends RestaurantEntity {
  RestaurantModel({
    required super.restaurantId,
    required super.name,
    required super.description,
    required super.latitude,
    required super.longitude,
    required super.isOpen,
    required super.imageUrl,
    required super.openTime,
    required super.closeTime,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      restaurantId: json['restaurant_id'],
      name: json['name'],
      description: json['description'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      isOpen: json['is_open'],
      imageUrl: json['image_url'],
      openTime: json['open_time'],
      closeTime: json['close_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'restaurant_id': restaurantId,
      'name': name,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'is_open': isOpen,
      'image_url': imageUrl,
      'open_time': openTime,
      'close_time': closeTime,
    };
  }
}
