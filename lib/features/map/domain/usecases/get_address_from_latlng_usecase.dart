
import 'package:dartz/dartz.dart';
import 'package:latlong2/latlong.dart';
import 'package:client/core/error/failures.dart';
import 'package:client/core/objects/entities/customer_location_entity.dart';
import 'package:client/features/map/domain/repositories/map_repository.dart';

class GetAddressFromLatLngUseCase {
  final MapRepository repository;

  GetAddressFromLatLngUseCase({required this.repository});

  Future<Either<Failure, OrderCustomerLocationEntity>> call({required LatLng latLng}) async {
    return await repository.getAddressFromlatlng(latLng: latLng);
  }
}