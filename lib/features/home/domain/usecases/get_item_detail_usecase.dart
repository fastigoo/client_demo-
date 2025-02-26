
import 'package:dartz/dartz.dart';
import 'package:learning/core/error/failures.dart';
import 'package:learning/features/home/domain/entities/item_detail_entity.dart';
import 'package:learning/features/home/domain/entities/menu_item_entity.dart';
import 'package:learning/features/home/domain/repositories/home_repository.dart';

class GetItemDetailUseCase {
  final HomeRepository repository;

  GetItemDetailUseCase({required this.repository});

  Future<Either<Failure, ItemDetailEntity>> execute({required int itemId}) {
    return repository.getItemDetail(itemId: itemId);
  }
}