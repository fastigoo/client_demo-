import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning/core/helper/utils.dart';
import 'package:learning/core/resources/storage_keys.dart';
import 'package:learning/core/services/storage_manager.dart';
import 'package:learning/features/cart/domain/usecases/all_orders_usecase.dart';
import 'package:learning/features/cart/domain/usecases/delete_order_usecase.dart';
import 'package:learning/features/orders/domain/entities/orders_res_entity.dart';

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

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels > scrollController.position.maxScrollExtent - 50) {
        loadMore();
      }
    });
    getOrders();
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
          update();
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
            update();
          },
        );
      } catch (e) {
        showToast(message: e.toString());
      } finally {
        isLoadingMore.value = false;
      }
    }
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
          update();
        },
      );
    } catch (e) {
      showToast(message: e.toString());
    }
  }
}
