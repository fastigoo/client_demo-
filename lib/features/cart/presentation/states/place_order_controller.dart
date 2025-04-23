import 'dart:convert';

import 'package:get/get.dart';
import 'package:learning/core/helper/utils.dart';
import 'package:learning/core/resources/apis.dart';
import 'package:learning/core/resources/states_ids.dart';
import 'package:learning/core/resources/storage_keys.dart';
import 'package:learning/core/services/storage_manager.dart';
import 'package:learning/core/services/web_socket_service.dart';
import 'package:learning/features/cart/domain/entities/order_detail_entity.dart';
import 'package:learning/features/cart/domain/usecases/order_detail_usecase.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PlaceOrderController extends GetxController {
  int orderId = 0;
  RxBool isLoading = false.obs;

  final orderDetailUseCase = Get.find<OrderDetailUseCase>();

  OrderDetailEntity? orderDetail;

  // int status = 1;

  late WebSocketChannel webSocketChannels;

  @override
  void onInit() {
    super.onInit();
    orderId = Get.arguments;
    getOrderDetail();
    int clientId = StorageManager.instance.getIntValue(key: StorageKey.clientIdKey);
    webSocketChannels = WebSocketService().connect(wsHost, clientId);
    webSocketChannels.stream.listen(
      (message) {
        Map<String, dynamic> data = jsonDecode(message);
        // order_status_id
        if (orderDetail!.orderId == data['order_id']) {
          orderDetail!.orderStatus.id = data['order_status_id'];
          orderDetail!.orderStatus.value = data['order_status_value'];
          // status = data['order_status_id'];
          update([StatesIds.orderDetail]);
        }
      },
      onError: (error) {},
      onDone: () {},
    );
  }

  Future<void> getOrderDetail() async {
    try {
      isLoading.value = true;
      var response = await orderDetailUseCase.execute(
        orderId: orderId,
      );
      response.fold(
        (l) {
          showToast(message: l.toString());
        },
        (OrderDetailEntity order) async {
          orderDetail = order;
          // status = order.orderStatus.id;
        },
      );
    } catch (e) {
      showToast(message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
