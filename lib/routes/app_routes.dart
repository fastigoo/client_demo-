part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const INITIAL = _Paths.INITIAL;
  static const HOME = _Paths.HOME;
  static const RESTO = _Paths.RESTO;
  static const PRODUCT_DETAIL = _Paths.PRODUCT_DETAIL;
  static const CART = _Paths.CART;
  static const PLACE_ORDER = _Paths.PLACE_ORDER;
  static const PROFILE = _Paths.PROFILE;
}

abstract class _Paths {
  _Paths._();
  static const INITIAL = '/splash';
  static const HOME = '/home';
  static const RESTO = '/restaurants';
  static const PRODUCT_DETAIL = '/product-detail';
  static const CART = '/cart';
  static const PLACE_ORDER = '/place-order';
  static const PROFILE = '/profile';
}