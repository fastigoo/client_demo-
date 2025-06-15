import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';
import 'package:client/core/objects/models/customer_location_model.dart';
import 'package:client/core/resources/apis.dart';

abstract interface class MapDataSource {
  Future<OrderCustomerLocationModel> getAddressFromlatlng({required LatLng latLng});
}

class MapDataSourceImplement implements MapDataSource {
  @override
  Future<OrderCustomerLocationModel> getAddressFromlatlng({required LatLng latLng}) async {
    try {
      Dio dio = Dio();
      Response response = await dio.get(
        '$getAddressFromLatlngUrl/${latLng.latitude}/${latLng.longitude}',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      return OrderCustomerLocationModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
