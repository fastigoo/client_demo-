import 'package:learning/features/free_order/data/models/free_order_item_model.dart';

class FreeOrderResEntity {
  final int itemsCount;
  final List<FreeOrderItemModel> orders;

  FreeOrderResEntity({
    required this.itemsCount,
    required this.orders,
  });
}