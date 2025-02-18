class RestaurantEntity {
  final int restaurantId;
  final String name;
  final String description;
  final double latitude;
  final double longitude;
  final bool isOpen;
  final String imageUrl;
  final String openTime;
  final String closeTime;

  RestaurantEntity({
    required this.restaurantId,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.isOpen,
    required this.imageUrl,
    required this.openTime,
    required this.closeTime,
  });
}