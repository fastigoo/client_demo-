import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learning/core/helper/utils.dart';
import 'package:learning/core/resources/language_strings.dart';
import 'package:learning/core/resources/storage_keys.dart';
import 'package:learning/core/services/storage_manager.dart';
import 'package:learning/features/free_order/domain/entities/free_order_item_list_entity.dart';
import 'package:learning/features/free_order/domain/entities/free_order_res_entity.dart';
import 'package:learning/features/free_order/domain/usecases/delete_free_order_usecase.dart';
import 'package:learning/features/free_order/domain/usecases/get_all_free_orders_usecase.dart';
import 'package:learning/features/free_order/domain/usecases/get_free_order_detail_usecase.dart';

class FreeOrdersController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingMore = false.obs;
  RxBool isDetailLoading = false.obs;
  FreeOrderResEntity? freeOrderResEntity;
  final _allFreeOrdersUsecase = Get.find<GetAllFreeOrdersUsecase>();
  final _deleteOrderUseCase = Get.find<DeleteFreeOrderUsecase>();
  final _freeOrderDetailUsecase = Get.find<GetFreeOrderDetailUsecase>();

  int page = 1;
  int perPage = 10;
  int maxPage = 1;
  ScrollController scrollController = ScrollController();

  int openedId = -1;
  List<FreeOrderItemListEntity> freeOrderItemList = [];

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels > scrollController.position.maxScrollExtent - 50) {
        loadMore();
      }
    });
    fetchFreeOrders();
  }

  void fetchFreeOrders() async {
    try {
      isLoading.value = true;
      var response = await _allFreeOrdersUsecase.call(
        userId: StorageManager.instance.getIntValue(key: StorageKey.userIdKey),
        page: page,
        limit: perPage,
      );
      response.fold(
        (l) {
          showToast(message: "${LanguageStrings.error}: $l");
        },
        (FreeOrderResEntity value) {
          freeOrderResEntity = value;
          maxPage = (value.totalOrders / perPage).ceil();
          update();
        },
      );
    } catch (e) {
      showToast(message: "${LanguageStrings.error}: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void loadMore() async {
    if (page < maxPage) {
      page++;
      try {
        isLoadingMore.value = true;
        var response = await _allFreeOrdersUsecase.call(
          userId: StorageManager.instance.getIntValue(key: StorageKey.userIdKey),
          page: page,
          limit: perPage,
        );
        response.fold(
          (l) {
            showToast(message: l.toString());
          },
          (FreeOrderResEntity value) async {
            freeOrderResEntity?.orders.addAll(value.orders);
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

  void deleteFreeOrder(int orderId) async {
    try {
      var response = await _deleteOrderUseCase.call(orderId: orderId);
      response.fold(
        (l) {
          showToast(message: l.toString());
        },
        (Unit unit) async {
          showToast(message: "Successfully deleted");
          freeOrderResEntity!.orders.removeWhere((element) => element.freeOrderId == orderId);
          update();
        },
      );
    } catch (e) {
      showToast(message: e.toString());
    }
  }

  void freeOrderDetail({required int id}) async {
    try {
      openedId = id;
      isDetailLoading.value = true;
      var response = await _freeOrderDetailUsecase.call(id: id);
      response.fold(
        (l) {
          showToast(message: "${LanguageStrings.error}: $l");
        },
        (List<FreeOrderItemListEntity> value) {
          freeOrderItemList = value;
        },
      );
    } catch (e) {
      showToast(message: "${LanguageStrings.error}: $e");
    } finally {
      isDetailLoading.value = false;
    }
  }
}
