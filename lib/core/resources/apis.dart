// const String port = '8080';
// const String host = 'http://165.232.87.86';
const String port = '8000';
const String host = 'http://192.168.1.61';
const String version = 'v1';
const String api = 'api';

const baseUrl = '$host:$port/$api/$version';


// Restaurant API
const String allRestaurantUrl = '$baseUrl/restaurants/get_all';

const String allRestaurantMenuUrl = '$baseUrl/restaurant_menu/get_all';
const String allRestaurantMenuItemsUrl = '$baseUrl/restaurant_menu_item/get_all';
const String itemDetailUrl = '$baseUrl/restaurant_menu_item';

// Address
const String getAddressFromLatlngUrl = '$baseUrl/place_info';


// Order
const String placeOrderUrl = '$baseUrl/order/place_order';
const String calculateDeliveryFeeUrl = '$baseUrl/order/estimate_delivery_fee';
const String getOrderDetailUrl = '$baseUrl/order/get';
const String allOrdersUrl = '$baseUrl/order/get_order/all';
const String deleteOrderUrl = '$baseUrl/order/delete';


// Free Order
const String addFreeOrderUrl = '$baseUrl/free_order/place_order';
const String deleteFreeOrderUrl = '$baseUrl/free_order/delete';
const String allFreeOrderUrl = '$baseUrl/free_order/get_free_order/all';
const String freeOrderDetailUrl = '$baseUrl/free_order/get';


