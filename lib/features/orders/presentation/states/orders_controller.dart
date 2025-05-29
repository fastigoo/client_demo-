import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning/core/helper/utils.dart';
import 'package:learning/core/resources/apis.dart';
import 'package:learning/core/resources/language_strings.dart';
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
    _connectToWebSocket();
  }

  @override
  void onClose() {
    scrollController.dispose();
    webSocketChannels.sink.close();
    super.onClose();
  }

  final WebSocketService _webSocketService = WebSocketService();
  void _connectToWebSocket() async  {
    try {
      final clientId = StorageManager.instance.getIntValue(key: StorageKey.clientIdKey);
      await _webSocketService.connect(wsHost, clientId, onMessage: (message) {
        debugPrint('WebSocket message: $message');
      });

      // channel.stream.listen(
      //   (message) {
      //     debugPrint('Raw message: $message');
      //
      //     try {
      //       final data = jsonDecode(message) as Map<String, dynamic>;
      //       debugPrint('Parsed data: $data');
      //
      //       final orderId = data['order_id'];
      //       if (orderResEntity.orders.any((o) => o.orderId == orderId)) {
      //         final index = orderResEntity.orders.indexWhere((o) => o.orderId == orderId);
      //         orderResEntity.orders[index].orderStatusValue = data['order_status_value'];
      //         update([StatesIds.ordersList]);
      //       }
      //     } catch (e) {
      //       debugPrint('Message parsing error: $e');
      //     }
      //   },
      //   onError: (error) => debugPrint('WebSocket stream error: $error'),
      //   onDone: () => debugPrint('WebSocket stream closed'),
      // );
    } catch (e) {
      debugPrint('WebSocket connection error: $e');
      // Add retry logic or UI notification
    }
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
          showToast(message: LanguageStrings.somethingWentWrong);
        },
        (OrderResEntity order) async {
          orderResEntity = order;
          maxPage = (order.totalOrders / limit).ceil();
          update([StatesIds.ordersList]);
        },
      );
    } catch (e) {
      showToast(message: LanguageStrings.somethingWentWrong);
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
            showToast(message: LanguageStrings.somethingWentWrong);
          },
          (OrderResEntity order) async {
            orderResEntity.orders.addAll(order.orders);
            update([StatesIds.ordersList]);
          },
        );
      } catch (e) {
        showToast(message: LanguageStrings.somethingWentWrong);
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
          showToast(message: LanguageStrings.somethingWentWrong);
        },
        (String message) async {
          showToast(message: message);
          orderResEntity.orders.removeWhere((element) => element.orderId == orderId);
          update([StatesIds.ordersList]);
        },
      );
    } catch (e) {
      showToast(message: LanguageStrings.somethingWentWrong);
    }
  }
}
