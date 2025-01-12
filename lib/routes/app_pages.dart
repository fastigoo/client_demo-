import 'package:get/get.dart';
import 'package:learning/features/cart/presentation/bindings/cart_binding.dart';
import 'package:learning/features/cart/presentation/screens/cart_screen.dart';
import 'package:learning/features/home/presentation/bindings/home_binding.dart';
import 'package:learning/features/home/presentation/bindings/product_detail_binding.dart';
import 'package:learning/features/home/presentation/screens/home_screen.dart';
import 'package:learning/features/home/presentation/screens/product_detail_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const HOME = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
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
  ];
}
