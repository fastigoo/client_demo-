import 'package:learning/features/home/domain/entities/variant_entity.dart';

class VariantModel extends VariantEntity {
  VariantModel({
    required super.menuItemVariantId,
    required super.menuItemId,
    required super.name,
    required super.description,
    required super.price,
    required super.imageUrl,
    required super.isAvailable,
  });

  factory VariantModel.fromJson(Map<String, dynamic> json) {
    return VariantModel(
      menuItemVariantId: json['menu_item_variant_id'],
      menuItemId: json['menu_item_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['image_url'],
      isAvailable: json['is_available'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menu_item_variant_id': menuItemVariantId,
      'menu_item_id': menuItemId,
      'name': name,
      'description': description,
      'price': price,
      'image_url': imageUrl,
      'is_available': isAvailable,
    };
  }
}
