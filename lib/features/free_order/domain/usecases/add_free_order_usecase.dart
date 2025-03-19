import 'package:dartz/dartz.dart';
import 'package:learning/core/error/failures.dart';
import 'package:learning/features/free_order/domain/repositories/free_order_repository.dart';
import 'package:learning/features/free_order/presentation/states/free_order_controller.dart';

class AddFreeOrderUsecase {
  final FreeOrderRepository repository;

  AddFreeOrderUsecase({required this.repository});

  Future<Either<Failure, String>> call({
    required String phone,
    required double latitude,
    required double longitude,
    required String fcm,
    required List<FreeOrderItemModel> items,
  }) async {
    return await repository.addFreeOrder(
      phone: phone,
      latitude: latitude,
      longitude: longitude,
      fcm: fcm,
      items: items,
    );
  }
}
