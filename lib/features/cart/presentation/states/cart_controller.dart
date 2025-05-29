import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:learning/core/helper/utils.dart';
import 'package:learning/core/objects/entities/customer_location_entity.dart';
import 'package:learning/core/resources/language_strings.dart';
import 'package:learning/core/resources/storage_keys.dart';
import 'package:learning/core/services/storage_manager.dart';
import 'package:learning/features/cart/domain/entities/cart_entity.dart';
import 'package:learning/features/cart/domain/entities/cart_item_entity.dart';
import 'package:learning/features/cart/domain/entities/delivery_fee_entity.dart';
import 'package:learning/features/cart/domain/entities/place_order_entity.dart';
import 'package:learning/features/cart/domain/usecases/calculate_delivery_fee_usecase.dart';
import 'package:learning/features/cart/domain/usecases/place_order_usecase.dart';
import 'package:learning/features/cart/presentation/states/map_controller.dart';
import 'package:learning/features/cart/presentation/widgets/confirm_order_component.dart';
import 'package:learning/routes/app_pages.dart';
import 'package:nb_utils/nb_utils.dart';

class CartController extends GetxController {
  TextEditingController phoneController = TextEditingController(text: "0");
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxList<CartEntity> cartItems = <CartEntity>[].obs;
  double lat = 0.0;
  double long = 0.0;
  int _restaurantId = 0;

  int get restaurantId => _restaurantId;

  final _mapController = Get.put(MapStreetController());

  final placeOrderUseCase = Get.find<PlaceOrderUseCase>();
  final deliveryFeeUseCase = Get.find<CalculateDeliveryFeeUseCase>();

  RxBool isPlacingOrder = false.obs;

  PlaceOrderEntity? orderEntity;

  OrderCustomerLocationEntity? address;

  bool isSameAddress() {
    return lat == 0.0 && long == 0.0;
  }

  void updateAddress({required LatLng pos}) {
    lat = pos.latitude;
    long = pos.longitude;
    update();
  }

  @override
  void onInit() {
    onMapCreated();
    phoneController.text = StorageManager.instance.getStringValue(key: StorageKey.userPhoneKey) ?? "0";
    super.onInit();
  }

  Future<void> onMapCreated() async {
    Position currentPos = await _mapController.getCurrentLocation();
    lat = currentPos.latitude;
    long = currentPos.longitude;
  }

  void setRestaurantId(int id) {
    _restaurantId = id;
  }

  void addToCart(CartEntity cartEntity) {
    final existingItemIndex = cartItems.indexWhere((item) => item.itemId == cartEntity.itemId);
    if (existingItemIndex != -1) {
      cartItems[existingItemIndex].quantity += 1;
    } else {
      cartItems.add(cartEntity);
      showToast(message: LanguageStrings.cartAddSuccess, gravity: ToastGravity.CENTER);
    }
    update();
  }

  void removeFromCart(CartEntity cartEntity) {
    cartItems.remove(cartEntity);
    update();
  }

  void addQuantity({required int itemId, int amount = 1}) {
    final itemIndex = cartItems.indexWhere((item) => item.itemId == itemId);

    if (itemIndex != -1) {
      cartItems[itemIndex].quantity += amount;
      update();
    }
  }

  void removeQuantity({required int itemId, int amount = 1}) {
    final itemIndex = cartItems.indexWhere((item) => item.itemId == itemId);

    if (itemIndex != -1) {
      if (cartItems[itemIndex].quantity > amount) {
        cartItems[itemIndex].quantity -= amount;
      } else {
        cartItems.removeAt(itemIndex);
      }
      update();
    }
  }

  double getTotalPrice() {
    double totalPrice = 0.0;
    for (var item in cartItems) {
      totalPrice += item.price * item.quantity;
    }
    return totalPrice;
  }

  void clearCart() {
    cartItems.clear();
    update();
  }

  void placeOrder({required int deliveryFee, required double distance}) async {
    List<CartItemEntity> items = [];
    for (var item in cartItems) {
      items.add(
        CartItemEntity(
          itemId: item.itemId,
          quantity: item.quantity,
          price: item.price,
        ),
      );
    }

    final String fcmToken = StorageManager.instance.getFcmToken() ?? "";

    try {
      isPlacingOrder.value = true;
      var response = await placeOrderUseCase.execute(
        phone: phoneController.text,
        restaurantId: _restaurantId,
        cartItems: items,
        lat: lat,
        long: long,
        deliveryFee: deliveryFee,
        distance: distance,
        fcm: fcmToken,
      );
      response.fold(
        (l) {
          showToast(message: LanguageStrings.somethingWentWrong);
        },
        (PlaceOrderEntity order) async {
          orderEntity = order;
          clearCart();
          showToast(message: LanguageStrings.orderPlacedSuccessfully);
          StorageManager.instance.setInt(key: StorageKey.userIdKey, value: order.userId);
          StorageManager.instance.setInt(key: StorageKey.clientIdKey, value: order.clientId);
          StorageManager.instance.setString(key: StorageKey.userPhoneKey, value: phoneController.text);
          Get.offAndToNamed(Routes.PLACE_ORDER, arguments: order.orderId);
        },
      );
    } catch (e) {
      showToast(message: LanguageStrings.somethingWentWrong);
    } finally {
      isPlacingOrder.value = false;
    }
  }

  void calculateOrderDeliveryFee() async {
    try {
      isPlacingOrder.value = true;
      var response = await deliveryFeeUseCase.execute(
        restaurantId: _restaurantId,
        lat: lat,
        long: long,
      );
      response.fold(
        (l) {
          showToast(message: LanguageStrings.somethingWentWrong);
        },
        (DeliveryFeeEntity value) async {
          showModalBottomSheet(
            context: Get.context!,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
              return SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: bottomPadding,
                  ),
                  child: ConfirmOrderComponent(
                    phoneController: phoneController,
                    formKey: formKey,
                    deliveryFeeEntity: value,
                  ),
                ),
              );
            },
          );
        },
      );
    } catch (e) {
      showToast(message: LanguageStrings.somethingWentWrong);
    } finally {
      isPlacingOrder.value = false;
    }
  }
}
