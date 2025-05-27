import 'package:learning/features/home/data/models/variant_model.dart';
import 'package:learning/features/home/domain/entities/item_detail_entity.dart';

class ItemDetailModel extends ItemDetailEntity {
  ItemDetailModel({
    required super.menuId,
    required super.menuItemId,
    required super.name,
    required super.description,
    required super.price,
    required super.imageUrl,
    required super.isAvailable,
    required super.hasVariant,
    super.variants,
  });

  factory ItemDetailModel.fromJson(Map<String, dynamic> json) {
    return ItemDetailModel(
      menuId: json['menu_id'],
      menuItemId: json['menu_item_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['image_url'],
      isAvailable: json['is_available'],
      hasVariant: json['has_variant'],
      variants: json['variants'] != null
          ? List<VariantModel>.from(
              json['variants'].map((x) => VariantModel.fromJson(x)))
          : null,
    );
  }
}
