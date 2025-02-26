import 'package:get/get.dart';
import 'package:learning/features/home/domain/entities/item_detail_entity.dart';
import 'package:learning/features/home/domain/usecases/get_item_detail_usecase.dart';

class ProductDetailController extends GetxController {
  int itemId = 0;
  RxBool isLoading = false.obs;

  final _itemDetailUseCase = Get.find<GetItemDetailUseCase>();

  ItemDetailEntity? _itemDetail;

  ItemDetailEntity? get itemDetail => _itemDetail;

  void setItemId(int id) {
    itemId = id;
    getItemDetails();
  }

  void getItemDetails() async {
    try {
      isLoading.value = true;
      final response = await _itemDetailUseCase.execute(itemId: itemId);
      response.fold(
        (l) {
          print(l);
        },
        (ItemDetailEntity item) {
          _itemDetail = item;
        },
      );
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
