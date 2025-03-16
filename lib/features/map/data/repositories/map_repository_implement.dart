import 'package:dartz/dartz.dart';
import 'package:latlong2/latlong.dart';
import 'package:learning/core/error/failures.dart';
import 'package:learning/core/objects/entities/customer_location_entity.dart';
import 'package:learning/features/map/data/datasources/map_data_source.dart';
import 'package:learning/features/map/domain/repositories/map_repository.dart';

class MapRepositoryImplement implements MapRepository {
  final MapDataSource mapDataSource;

  MapRepositoryImplement({required this.mapDataSource});

  @override
  Future<Either<Failure, OrderCustomerLocationEntity>> getAddressFromlatlng({required LatLng latLng}) async {
    OrderCustomerLocationEntity locationEntity = await mapDataSource.getAddressFromlatlng(latLng: latLng);
    return Right(locationEntity);
  }
}