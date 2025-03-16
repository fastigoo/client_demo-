import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:learning/core/helper/utils.dart';
import 'package:learning/features/cart/domain/entities/cart_entity.dart';
import 'package:learning/features/cart/domain/entities/cart_item_entity.dart';
import 'package:learning/features/cart/domain/entities/delivery_fee_entity.dart';
import 'package:learning/features/cart/domain/entities/place_order_entity.dart';
import 'package:learning/features/cart/domain/usecases/calculate_delivery_fee_usecase.dart';
import 'package:learning/features/cart/domain/usecases/place_order_usecase.dart';
import 'package:learning/features/cart/presentation/states/map_controller.dart';
import 'package:learning/features/cart/presentation/widgets/confirm_order_component.dart';
import 'package:learning/routes/app_pages.dart';

class CartController extends GetxController {
  TextEditingController phoneController = TextEditingController(text: "0555555555");
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

  @override
  void onInit() {
    onMapCreated();
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
      items.add(CartItemEntity(
        itemId: item.itemId,
        quantity: item.quantity,
        price: item.price,
      ));
    }

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
      );
      response.fold(
        (l) {
          showToast(message: l.toString());
        },
        (PlaceOrderEntity order) async {
          orderEntity = order;
          clearCart();
          showToast(message: 'Order placed successfully');
          Get.toNamed(Routes.PLACE_ORDER, arguments: order.orderId);
        },
      );
    } catch (e) {
      showToast(message: e.toString());
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
          showToast(message: l.toString());
        },
        (DeliveryFeeEntity value) async {
          showModalBottomSheet(
            context: Get.context!,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => ConfirmOrderComponent(
              phoneController: phoneController,
              formKey: formKey,
              deliveryFeeEntity: value,
            ),
          );
        },
      );
    } catch (e) {
      showToast(message: e.toString());
    } finally {
      isPlacingOrder.value = false;
    }
  }
}
