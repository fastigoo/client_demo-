

import 'package:dartz/dartz.dart';
import 'package:latlong2/latlong.dart';
import 'package:learning/core/error/failures.dart';
import 'package:learning/core/objects/entities/customer_location_entity.dart';

abstract interface class MapRepository {
  Future<Either<Failure, OrderCustomerLocationEntity>> getAddressFromlatlng({required LatLng latLng});
}