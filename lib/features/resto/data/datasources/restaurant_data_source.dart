import 'package:dio/dio.dart';
import 'package:client/core/resources/apis.dart';
import 'package:client/features/resto/data/models/restaurants_model.dart';

abstract interface class RestaurantDataSource {
  Future<RestaurantsModel> getRestaurants({required int page, required int perPage, String name = ""});
}

class RestaurantDataSourceImplement implements RestaurantDataSource {
  @override
  Future<RestaurantsModel> getRestaurants({required int page, required int perPage, String name = ""}) async {
    try {
      Dio dio = Dio();
      Response response = await dio.get(
        '$allRestaurantUrl?page_number=$page&page_size=$perPage&name=$name',
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );
      return RestaurantsModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
