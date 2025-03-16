import 'package:get/get.dart';
import 'package:learning/core/helper/utils.dart';
import 'package:learning/features/cart/domain/entities/order_detail_entity.dart';
import 'package:learning/features/cart/domain/usecases/order_detail_usecase.dart';

class PlaceOrderController extends GetxController {
  int orderId = 0;
  RxBool isLoading = false.obs;

  final orderDetailUseCase = Get.find<OrderDetailUseCase>();

  OrderDetailEntity? orderDetail;

  int status = 1;

  @override
  void onInit() {
    orderId = Get.arguments;
    getOrderDetail();
    super.onInit();
  }

  void getOrderDetail() async {
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
          status = order.orderStatus.id;
        },
      );
    } catch (e) {
      showToast(message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
