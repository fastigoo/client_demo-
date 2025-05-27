import 'package:learning/core/objects/entities/order_restaurant_entity.dart';

class OrderRestaurantModel extends OrderRestaurantEntity {
  OrderRestaurantModel({
    required super.id,
    required super.name,
    required super.imageUrl,
  });

  factory OrderRestaurantModel.fromJson(Map<String, dynamic> json) {
    return OrderRestaurantModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['img_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'img_url': imageUrl,
    };
  }
}
