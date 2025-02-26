import 'package:dio/dio.dart';
import 'package:learning/core/error/exceptions.dart';
import 'package:learning/core/resources/apis.dart';
import 'package:learning/features/cart/data/models/delivery_fee_model.dart';
import 'package:learning/features/cart/data/models/place_order_model.dart';
import 'package:learning/features/cart/domain/entities/cart_item_entity.dart';

abstract interface class OrderDataSource {
  Future<PlaceOrderModel> placeOrder({
    required int restaurantId,
    required String phone,
    required double lat,
    required double long,
    required List<CartItemEntity> cartItems,
  });

  Future<DeliveryFeeModel> calculateDeliveryFee({
    required int restaurantId,
    required double lat,
    required double long,
  });
}

class OrderDataSourceImplement implements OrderDataSource {
  @override
  Future<PlaceOrderModel> placeOrder({
    required int restaurantId,
    required String phone,
    required double lat,
    required double long,
    required List<CartItemEntity> cartItems,
  }) async {
    try {
      Dio dio = Dio();
      Response response = await dio.post(
        placeOrderUrl,
        data: {
          'restaurant_id': restaurantId,
          'phone_number': phone,
          'latitude': lat,
          'longitude': long,
          'items': cartItems.map((e) => e.toJson()).toList(),
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return PlaceOrderModel.fromJson(response.data);
      }

      throw CustomException(msg: response.data['message']);
    } catch (e) {
      throw CustomException(msg: e.toString());
    }
  }

  @override
  Future<DeliveryFeeModel> calculateDeliveryFee({required int restaurantId, required double lat, required double long}) async {
    try {
      Dio dio = Dio();
      Response response = await dio.post(
        calculateDeliveryFeeUrl,
        data: {
          'restaurant_id': restaurantId,
          'latitude': lat,
          'longitude': long
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return DeliveryFeeModel.fromJson(response.data);
      }

      throw CustomException(msg: response.data['message']);
    } catch (e) {
      print(e);
      throw CustomException(msg: e.toString());
    }
  }
}
