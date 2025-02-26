import 'package:learning/features/home/domain/entities/variant_entity.dart';

class ItemDetailEntity {
  final int menuItemId;
  final int menuId;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final bool isAvailable;
  final bool hasVariant;
  final List<VariantEntity>? variants;

  ItemDetailEntity({
    required this.menuId,
    required this.menuItemId,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.isAvailable,
    required this.hasVariant,
    this.variants,
  });
}
