class MenuItemEntity {
  final int menuId;
  final int menuItemId;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final bool isAvailable;
  final bool hasVariant;
  final int? parentMenuItemId;

  MenuItemEntity({
    required this.menuId,
    required this.menuItemId,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.isAvailable,
    required this.hasVariant,
    this.parentMenuItemId,
  });
}
