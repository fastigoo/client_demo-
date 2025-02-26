class CartItemEntity {
  final int itemId;
  final double price;
  final int quantity;

  CartItemEntity({
    required this.itemId,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'item_id': itemId,
      'price': price,
      'quantity': quantity,
    };
  }
}
