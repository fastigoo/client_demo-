import 'package:client/features/home/domain/entities/restaurant_menu_entity.dart';

class RestaurantMenuModel extends RestaurantMenuEntity {
  RestaurantMenuModel({
    required super.menuId,
    required super.restaurantId,
    required super.name,
  });

  factory RestaurantMenuModel.fromJson(Map<String, dynamic> json) {
    return RestaurantMenuModel(
      menuId: json['menu_id'],
      restaurantId: json['restaurant_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menu_id': menuId,
      'restaurant_id': restaurantId,
      'name': name,
    };
  }
}
