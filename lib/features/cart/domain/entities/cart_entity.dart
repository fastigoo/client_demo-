

class CartEntity {
  final String name;
  final int itemId;
  final double price;
  int quantity;
  final String image;

  CartEntity({
    required this.name,
    required this.itemId,
    required this.price,
    required this.quantity,
    required this.image,
  });
}