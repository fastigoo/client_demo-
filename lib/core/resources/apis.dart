const String port = '8000';
const String host = 'http://192.168.1.59';
const String version = 'v1';
const String api = 'api';

const baseUrl = '$host:$port/$api/$version';


// Restaurant API
const String allRestaurantUrl = '$baseUrl/restaurants/get_all';

const String allRestaurantMenuUrl = '$baseUrl/restaurant_menu/get_all';
const String allRestaurantMenuItemsUrl = '$baseUrl/restaurant_menu_item/get_all';
const String itemDetailUrl = '$baseUrl/restaurant_menu_item';


// Order
const String placeOrderUrl = '$baseUrl/order/place_order';
const String calculateDeliveryFeeUrl = '$baseUrl/order/estimate_delivery_fee';
const String getOrderDetailUrl = '$baseUrl/order/get';


