import 'package:dio/dio.dart';
import 'package:learning/core/resources/apis.dart';
import 'package:learning/features/free_order/data/models/free_order_item_list_model.dart';
import 'package:learning/features/free_order/data/models/free_order_model.dart';
import 'package:learning/features/free_order/presentation/states/free_order_controller.dart';

abstract interface class FreeOrderDatasource {
  Future<FreeOrderResModel> getFreeOrders({required int page, int limit = 10});

  Future<List<FreeOrderItemListModel>> getFreeOrderList({required int id});

  Future<String> addFreeOrder({
    required String phone,
    required double latitude,
    required double longitude,
    required String fcm,
    required List<FreeOrderItemModel> items,
  });
}

class FreeOrderDatasourceImplement implements FreeOrderDatasource {
  @override
  Future<FreeOrderResModel> getFreeOrders({required int page, int limit = 10}) async {
    try {
      Dio dio = Dio();
      Response response = await dio.get(
        '$allFreeOrderUrl?page_num=$page&page_size=$limit',
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
      Dio dio = Dio();
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
  Future<String> addFreeOrder({
    required String phone,
    required double latitude,
    required double longitude,
    required String fcm,
    required List<FreeOrderItemModel> items,
  }) async {
    try {
      Dio dio = Dio();
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
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
