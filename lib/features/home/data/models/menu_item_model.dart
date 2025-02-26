import 'package:learning/features/home/domain/entities/menu_item_entity.dart';

class MenuItemModel extends MenuItemEntity {
  MenuItemModel({
    required super.menuId,
    required super.menuItemId,
    required super.name,
    required super.description,
    required super.price,
    required super.imageUrl,
    required super.isAvailable,
    required super.hasVariant,
    super.parentMenuItemId,
  });

  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    return MenuItemModel(
      menuId: json['menu_id'],
      menuItemId: json['menu_item_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['image_url'],
      isAvailable: json['is_available'],
      hasVariant: json['has_variant'],
      parentMenuItemId: json['parent_menu_item_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menu_id': menuId,
      'menu_item_id': menuItemId,
      'name': name,
      'description': description,
      'price': price,
      'image_url': imageUrl,
      'is_available': isAvailable,
      'has_variant': hasVariant,
      'parent_menu_item_id': parentMenuItemId,
    };
  }
}
