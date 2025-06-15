import 'package:client/core/error/failures.dart';
import 'package:client/core/objects/entities/customer_location_entity.dart';
import 'package:client/features/map/data/datasources/map_data_source.dart';
import 'package:client/features/map/domain/repositories/map_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:latlong2/latlong.dart';

class MapRepositoryImplement implements MapRepository {
  final MapDataSource mapDataSource;

  MapRepositoryImplement({required this.mapDataSource});

  @override
  Future<Either<Failure, OrderCustomerLocationEntity>> getAddressFromlatlng({required LatLng latLng}) async {
    OrderCustomerLocationEntity locationEntity = await mapDataSource.getAddressFromlatlng(latLng: latLng);
    return Right(locationEntity);
  }
}