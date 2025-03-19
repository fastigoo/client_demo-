import 'package:get/get.dart';
import 'package:learning/core/helper/utils.dart';
import 'package:learning/features/free_order/domain/entities/free_order_item_list_entity.dart';
import 'package:learning/features/free_order/domain/entities/free_order_res_entity.dart';
import 'package:learning/features/free_order/domain/usecases/get_all_free_orders_usecase.dart';
import 'package:learning/features/free_order/domain/usecases/get_free_order_detail_usecase.dart';

class FreeOrdersController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isDetailLoading = false.obs;
  FreeOrderResEntity? freeOrderResEntity;
  final _allFreeOrdersUsecase = Get.find<GetAllFreeOrdersUsecase>();
  final _freeOrderDetailUsecase = Get.find<GetFreeOrderDetailUsecase>();

  int page = 1;
  int perPage = 10;

  int openedId = -1;
  List<FreeOrderItemListEntity> freeOrderItemList = [];

  @override
  void onInit() {
    super.onInit();
    fetchFreeOrders();
  }

  void fetchFreeOrders() async {
    try {
      isLoading.value = true;
      var response = await _allFreeOrdersUsecase.call(page: page, limit: perPage);
      response.fold(
        (l) {
          showToast(message: "Error: $l");
        },
        (FreeOrderResEntity value) {
          page += 1;
          freeOrderResEntity ??= value;
        },
      );
    } catch (e) {
      showToast(message: "Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void freeOrderDetail({required int id}) async {
    try {
      openedId = id;
      isDetailLoading.value = true;
      var response = await _freeOrderDetailUsecase.call(id: id);
      response.fold(
        (l) {
          showToast(message: "Error: $l");
        },
        (List<FreeOrderItemListEntity> value) {
          freeOrderItemList = value;
        },
      );
    } catch (e) {
      showToast(message: "Error: $e");
    } finally {
      isDetailLoading.value = false;
    }
  }
}
