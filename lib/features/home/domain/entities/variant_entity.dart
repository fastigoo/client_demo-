class VariantEntity {
  final int menuItemVariantId;
  final int menuItemId;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final bool isAvailable;

  VariantEntity({
    required this.menuItemVariantId,
    required this.menuItemId,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.isAvailable,
  });
}
