part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const INITIAL = _Paths.INITIAL;
  static const MAP = _Paths.MAP;
  static const RESTO = _Paths.RESTO;
  static const FREE_ORDER = _Paths.FREE_ORDER;
  static const FREE_ORDERS = _Paths.FREE_ORDERS;
  static const SUCCESS = _Paths.SUCCESS;
  static const ORDERS = _Paths.ORDERS;
  static const HOME = _Paths.HOME;
  static const PRODUCT_DETAIL = _Paths.PRODUCT_DETAIL;
  static const CART = _Paths.CART;
  static const PLACE_ORDER = _Paths.PLACE_ORDER;
  static const PROFILE = _Paths.PROFILE;
}

abstract class _Paths {
  _Paths._();
  static const INITIAL = '/splash';
  static const MAP = '/map';
  static const RESTO = '/restaurants';
  static const FREE_ORDER = '/free-order';
  static const FREE_ORDERS = '/free-orders';
  static const SUCCESS = '/success';
  static const ORDERS = '/orders';
  static const HOME = '/home';
  static const PRODUCT_DETAIL = '/product-detail';
  static const CART = '/cart';
  static const PLACE_ORDER = '/place-order';
  static const PROFILE = '/profile';
}