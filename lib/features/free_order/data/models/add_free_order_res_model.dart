import 'package:learning/features/free_order/domain/entities/add_free_order_res_entity.dart';

class AddFreeOrderResModel extends AddFreeOrderResEntity {
  AddFreeOrderResModel({
    required super.freeOrderId,
    required super.userId,
  });

  factory AddFreeOrderResModel.fromJson(Map<String, dynamic> json) {
    return AddFreeOrderResModel(
      freeOrderId: json['free_order_id'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'free_order_id': freeOrderId,
      'user_id': userId,
    };
  }
}
