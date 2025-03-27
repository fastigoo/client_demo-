import 'package:dio/dio.dart';
import 'package:learning/core/resources/apis.dart';
import 'package:learning/features/orders/data/models/order_res_model.dart';

abstract interface class OrdersDataSource {
  Future<OrderResModel> getOrders({required int userId, required int page, int limit = 10});
  // Future<String> deleteOrder({required int orderId});
}

class OrdersDataSourceImplement implements OrdersDataSource {
  @override
  Future<OrderResModel> getOrders({required int userId, required int page, limit = 10}) async {
    try {
      Dio dio = Dio();
      Response response = await dio.get(
        allOrdersUrl,
        queryParameters: {
          'user_id': userId,
          'page_num': page,
          'page_size': limit,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      print(response.data);

      return OrderResModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

}