import 'package:get/get.dart';
import 'package:learning/core/helper/utils.dart';
import 'package:learning/core/resources/states_ids.dart';
import 'package:learning/features/home/domain/entities/item_detail_entity.dart';
import 'package:learning/features/home/domain/entities/variant_entity.dart';
import 'package:learning/features/home/domain/usecases/get_item_detail_usecase.dart';

class ProductDetailController extends GetxController {
  int itemId = 0;
  RxBool isLoading = false.obs;

  final _itemDetailUseCase = Get.find<GetItemDetailUseCase>();

  ProductDetailModel? initialProductDetailModel;
  ProductDetailModel? variantProductDetailModel;

  int selectedVariant = 0;

  void setItemId(int id) {
    itemId = id;
    getItemDetails();
  }

  void setSelectedVariant({required int value, required int index}) {
    if (initialProductDetailModel == null) return;
    selectedVariant = value;
    if (selectedVariant == 0) {
      variantProductDetailModel = initialProductDetailModel;
    } else {
      variantProductDetailModel = ProductDetailModel(
        name: initialProductDetailModel!.variants![index].name,
        description: initialProductDetailModel!.variants![index].description,
        price: initialProductDetailModel!.variants![index].price,
        imageUrl: initialProductDetailModel!.variants![index].imageUrl,
        menuItemId: selectedVariant,
      );
    }
    update([StatesIds.productDetail]);
  }

  bool isSameVariant(int index) {
    return selectedVariant == index;
  }

  ProductDetailModel? get productDetailModel {
    if (variantProductDetailModel != null) {
      return variantProductDetailModel;
    } else {
      return initialProductDetailModel;
    }
  }

  void getItemDetails() async {
    try {
      isLoading.value = true;
      final response = await _itemDetailUseCase.execute(itemId: itemId);
      response.fold(
        (l) {
          showToast(message: l.toString());
        },
        (ItemDetailEntity item) {
          // _itemDetail = item;
          initialProductDetailModel = ProductDetailModel(
            name: item.name,
            description: item.description,
            price: item.price,
            imageUrl: item.imageUrl,
            menuItemId: item.menuItemId,
            variants: item.variants,
          );
        },
      );
    } catch (e) {
      showToast(message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

class ProductDetailModel {
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final int menuItemId;
  final List<VariantEntity>? variants;

  ProductDetailModel({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.menuItemId,
    this.variants,
  });
}
