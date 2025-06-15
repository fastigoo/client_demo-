import 'package:client/features/resto/data/models/restaurant_model.dart';
import 'package:client/features/resto/domain/entities/restaurants_entity.dart';

class RestaurantsModel extends RestaurantsEntity {
  RestaurantsModel({
    required super.totalCount,
    required super.restaurants,
  });

  factory RestaurantsModel.fromJson(Map<String, dynamic> json) {
    return RestaurantsModel(
      totalCount: json['total_count'],
      restaurants: List<RestaurantModel>.from(
        json['restaurants'].map(
          (x) => RestaurantModel.fromJson(x),
        ),
      ),
    );
  }
}
