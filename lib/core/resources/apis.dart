// Localhost API configuration
// const String port = '8000';
// const String ipAddress = "192.168.1.58";
// const String host = 'http://$ipAddress';
// const String wsHost = 'ws://$ipAddress:8000/ws/client/';
// const String version = 'v1';
// const String api = 'api';


// Server API configuration
const String host = 'http://www.fastiigo.com';
const String wsHost = 'ws://www.fastiigo.com/ws/client/';
const String version = 'v1';
const String api = 'api';

const baseUrl = '$host/$api/$version';

// Restaurant API
const String allRestaurantUrl = '$baseUrl/restaurant/get_all';

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


