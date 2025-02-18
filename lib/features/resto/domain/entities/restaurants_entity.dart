import 'package:learning/features/resto/domain/entities/restaurant_entity.dart';

class RestaurantsEntity {
  final int totalCount;
  final List<RestaurantEntity> restaurants;

  RestaurantsEntity({
    required this.totalCount,
    required this.restaurants,
  });
}