import 'package:get/get.dart';
import 'package:client/core/screens/success_screen.dart';
import 'package:client/features/cart/presentation/bindings/cart_binding.dart';
import 'package:client/features/cart/presentation/bindings/place_order_binding.dart';
import 'package:client/features/cart/presentation/screens/cart_screen.dart';
import 'package:client/features/cart/presentation/screens/order_place_screen.dart';
import 'package:client/features/free_order/presentation/bindings/free_orders_list_binding.dart';
import 'package:client/features/free_order/presentation/screens/free_orders_list_screen.dart';
import 'package:client/features/home/presentation/bindings/home_binding.dart';
import 'package:client/features/home/presentation/bindings/product_detail_binding.dart';
import 'package:client/features/home/presentation/screens/home_screen.dart';
import 'package:client/features/home/presentation/screens/product_detail_screen.dart';
import 'package:client/features/map/presentation/bindings/map_binding.dart';
import 'package:client/features/map/presentation/screens/map_screen.dart';
import 'package:client/features/orders/presentation/bindings/orders_binding.dart';
import 'package:client/features/orders/presentation/screens/orders_screen.dart';
import 'package:client/features/free_order/presentation/bindings/free_order_binding.dart';
import 'package:client/features/resto/presentation/bindings/resto_binding.dart';
import 'package:client/features/free_order/presentation/screens/free_order_screen.dart';
import 'package:client/features/resto/presentation/screens/resto_screen.dart';
import 'package:client/features/settings/presentation/bindings/settings_binding.dart';
import 'package:client/features/settings/presentation/screens/settings_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const RESTO = Routes.RESTO;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MAP,
      page: () => const MapScreen(),
      binding: MapBinding(),
    ),
    GetPage(
      name: _Paths.RESTO,
      page: () => const RestoScreen(),
      binding: RestoBinding(),
    ),
    GetPage(
      name: _Paths.FREE_ORDER,
      page: () => const FreeOrderScreen(),
      binding: FreeOrderBinding(),
    ),
    GetPage(
      name: _Paths.FREE_ORDERS,
      page: () => const FreeOrdersListScreen(),
      binding: FreeOrdersBinding(),
    ),
    GetPage(
      name: _Paths.SUCCESS,
      page: () => const SuccessScreen(),
    ),
    GetPage(
      name: _Paths.ORDERS,
      page: () => const OrdersScreen(),
      binding: OrdersBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAIL,
      page: () => const ProductDetailScreen(),
      binding: ProductDetailBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartScreen(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.PLACE_ORDER,
      page: () => const PlaceOrderScreen(),
      binding: PlaceOrderBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsScreen(),
      binding: SettingsBinding(),
    ),
  ];
}
