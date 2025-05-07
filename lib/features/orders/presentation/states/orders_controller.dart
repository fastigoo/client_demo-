import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning/core/helper/utils.dart';
import 'package:learning/core/resources/apis.dart';
import 'package:learning/core/resources/states_ids.dart';
import 'package:learning/core/resources/storage_keys.dart';
import 'package:learning/core/services/storage_manager.dart';
import 'package:learning/core/services/web_socket_service.dart';
import 'package:learning/features/cart/domain/usecases/all_orders_usecase.dart';
import 'package:learning/features/cart/domain/usecases/delete_order_usecase.dart';
import 'package:learning/features/orders/domain/entities/orders_res_entity.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class OrdersController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingMore = false.obs;
  late OrderResEntity orderResEntity;

  final _allOrdersUseCase = Get.find<AllOrdersUseCase>();
  final _deleteOrderUseCase = Get.find<DeleteOrderUseCase>();

  final scrollController = ScrollController();

  int page = 1;
  int maxPage = 1;
  int limit = 10;

  late WebSocketChannel webSocketChannels;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels > scrollController.position.maxScrollExtent - 50) {
        loadMore();
      }
    });
    getOrders();
    int clientId = StorageManager.instance.getIntValue(key: StorageKey.clientIdKey);
    webSocketChannels = WebSocketService().connect(wsHost, clientId);
    webSocketChannels.stream.listen(
      (message) {
        Map<String, dynamic> data = jsonDecode(message);
        // order_status_id
        if (orderResEntity.orders.any((element) => element.orderId == data['order_id'])) {
          int index = orderResEntity.orders.indexWhere((element) => element.orderId == data['order_id']);
          orderResEntity.orders[index].orderStatusValue = data['order_status_value'];
          update([StatesIds.ordersList]);
        }
      },
      onError: (error) {},
      onDone: () {},
    );
  }

  void getOrders() async {
    try {
      isLoading.value = true;
      var response = await _allOrdersUseCase.execute(
        userId: StorageManager.instance.getIntValue(key: StorageKey.userIdKey),
        page: page,
        limit: limit,
      );
      response.fold(
        (l) {
          showToast(message: l.toString());
        },
        (OrderResEntity order) async {
          orderResEntity = order;
          maxPage = (order.totalOrders / limit).ceil();
          update([StatesIds.ordersList]);
        },
      );
    } catch (e) {
      showToast(message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void loadMore() async {
    if (page < maxPage) {
      page++;
      try {
        isLoadingMore.value = true;
        var response = await _allOrdersUseCase.execute(
          userId: StorageManager.instance.getIntValue(key: StorageKey.userIdKey),
          page: page,
          limit: limit,
        );
        response.fold(
          (l) {
            showToast(message: l.toString());
          },
          (OrderResEntity order) async {
            orderResEntity.orders.addAll(order.orders);
            update([StatesIds.ordersList]);
          },
        );
      } catch (e) {
        showToast(message: e.toString());
      } finally {
        isLoadingMore.value = false;
      }
    }
  }

  void refreshData() {
    page = 1;
    maxPage = 1;
    getOrders();
  }

  void deleteOrder(int orderId) async {
    try {
      var response = await _deleteOrderUseCase.execute(orderId: orderId);
      response.fold(
        (l) {
          showToast(message: l.toString());
        },
        (String message) async {
          showToast(message: message);
          orderResEntity.orders.removeWhere((element) => element.orderId == orderId);
          update([StatesIds.ordersList]);
        },
      );
    } catch (e) {
      showToast(message: e.toString());
    }
  }
}
