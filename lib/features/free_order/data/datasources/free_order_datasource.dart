import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:client/core/resources/apis.dart';
import 'package:client/features/free_order/data/models/add_free_order_res_model.dart';
import 'package:client/features/free_order/data/models/free_order_item_list_model.dart';
import 'package:client/features/free_order/data/models/free_order_model.dart';
import 'package:client/features/free_order/presentation/states/free_order_controller.dart';

abstract interface class FreeOrderDatasource {
  Future<FreeOrderResModel> getFreeOrders({required int userId, required int page, int limit = 10});
  Future<Unit> deleteFreeOrders({required int orderId});
  Future<List<FreeOrderItemListModel>> getFreeOrderList({required int id});

  Future<AddFreeOrderResModel> addFreeOrder({
    required String phone,
    required double latitude,
    required double longitude,
    required String fcm,
    required List<FreeOrderItemModel> items,
  });
}

class FreeOrderDatasourceImplement implements FreeOrderDatasource {

  Dio dio = Dio();

  @override
  Future<FreeOrderResModel> getFreeOrders({required int userId, required int page, int limit = 10}) async {
    try {
      Response response = await dio.get(
        '$allFreeOrderUrl?user_id=$userId&page_num=$page&page_size=$limit',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      return FreeOrderResModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<FreeOrderItemListModel>> getFreeOrderList({required int id}) async {
    try {
      Response response = await dio.get(
        '$freeOrderDetailUrl/$id',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      return (response.data as List).map((e) => FreeOrderItemListModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AddFreeOrderResModel> addFreeOrder({
    required String phone,
    required double latitude,
    required double longitude,
    required String fcm,
    required List<FreeOrderItemModel> items,
  }) async {
    try {
      Response response = await dio.post(
        addFreeOrderUrl,
        data: {
          "phone_number": phone,
          "latitude": latitude,
          "longitude": longitude,
          "fcm": fcm,
          "items": items.map((e) => e.toJson()).toList(),
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );
      return AddFreeOrderResModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> deleteFreeOrders({required int orderId}) async {
    try {
      Response response = await dio.delete(
        '$deleteFreeOrderUrl/$orderId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return unit;
      } else {
        throw Exception('Failed to delete order');
      }
    } catch (e) {
      rethrow;
    }
  }
}
