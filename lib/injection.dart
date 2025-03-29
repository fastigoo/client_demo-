import 'package:get/get.dart';
import 'package:learning/features/cart/data/datasources/order_data_source.dart';
import 'package:learning/features/cart/data/repositories/order_repository_implement.dart';
import 'package:learning/features/cart/domain/repositories/order_repository.dart';
import 'package:learning/features/cart/domain/usecases/all_orders_usecase.dart';
import 'package:learning/features/cart/domain/usecases/calculate_delivery_fee_usecase.dart';
import 'package:learning/features/cart/domain/usecases/delete_order_usecase.dart';
import 'package:learning/features/cart/domain/usecases/delete_order_usecase.dart';
import 'package:learning/features/cart/domain/usecases/order_detail_usecase.dart';
import 'package:learning/features/cart/domain/usecases/place_order_usecase.dart';
import 'package:learning/features/free_order/data/datasources/free_order_datasource.dart';
import 'package:learning/features/free_order/data/repositories/free_order_repository_implement.dart';
import 'package:learning/features/free_order/domain/repositories/free_order_repository.dart';
import 'package:learning/features/free_order/domain/usecases/add_free_order_usecase.dart';
import 'package:learning/features/free_order/domain/usecases/add_free_order_usecase.dart';
import 'package:learning/features/free_order/domain/usecases/delete_free_order_usecase.dart';
import 'package:learning/features/free_order/domain/usecases/delete_free_order_usecase.dart';
import 'package:learning/features/free_order/domain/usecases/get_all_free_orders_usecase.dart';
import 'package:learning/features/free_order/domain/usecases/get_free_order_detail_usecase.dart';
import 'package:learning/features/home/data/datasources/home_datasource.dart';
import 'package:learning/features/home/data/repositories/home_repository_implement.dart';
import 'package:learning/features/home/domain/repositories/home_repository.dart';
import 'package:learning/features/home/domain/usecases/get_all_restaurant_menus_usecase.dart';
import 'package:learning/features/home/domain/usecases/get_item_detail_usecase.dart';
import 'package:learning/features/home/domain/usecases/get_restaurant_menu_items_usecase.dart';
import 'package:learning/features/map/data/datasources/map_data_source.dart';
import 'package:learning/features/map/data/repositories/map_repository_implement.dart';
import 'package:learning/features/map/domain/repositories/map_repository.dart';
import 'package:learning/features/map/domain/usecases/get_address_from_latlng_usecase.dart';
import 'package:learning/features/resto/data/datasources/restaurant_data_source.dart';
import 'package:learning/features/resto/data/repositories/restaurant_repository_implement.dart';
import 'package:learning/features/resto/domain/repositories/restaurant_repository.dart';
import 'package:learning/features/resto/domain/usecases/all_restaurant_usecase.dart';

Future<void> injectionInit() async {
  // Restaurant
  Get.put<RestaurantDataSource>(RestaurantDataSourceImplement());
  Get.put<RestaurantRepository>(RestaurantRepositoryImplement(remote: Get.find<RestaurantDataSource>()));

  Get.put<AllRestaurantUsecase>(AllRestaurantUsecase(repository: Get.find<RestaurantRepository>()));

  // Free Order
  Get.put<FreeOrderDatasource>(FreeOrderDatasourceImplement());
  Get.put<FreeOrderRepository>(FreeOrderRepositoryImplement(remoteDataSource: Get.find<FreeOrderDatasource>()));

  Get.put<GetAllFreeOrdersUsecase>(GetAllFreeOrdersUsecase(repository: Get.find<FreeOrderRepository>()));
  Get.put<DeleteFreeOrderUsecase>(DeleteFreeOrderUsecase(repository: Get.find<FreeOrderRepository>()));

  Get.put<GetFreeOrderDetailUsecase>(GetFreeOrderDetailUsecase(repository: Get.find<FreeOrderRepository>()));
  Get.put<AddFreeOrderUsecase>(AddFreeOrderUsecase(repository: Get.find<FreeOrderRepository>()));

  // Home
  Get.put<HomeDataSource>(HomeDataSourceImplement());
  Get.put<HomeRepository>(HomeRepositoryImplement(remoteDataSource: Get.find<HomeDataSource>()));

  Get.put<GetAllRestaurantMenusUseCase>(GetAllRestaurantMenusUseCase(repository: Get.find<HomeRepository>()));
  Get.put<GetRestaurantMenuItemsUseCase>(GetRestaurantMenuItemsUseCase(repository: Get.find<HomeRepository>()));
  Get.put<GetItemDetailUseCase>(GetItemDetailUseCase(repository: Get.find<HomeRepository>()));

  // Map
  Get.put<MapDataSource>(MapDataSourceImplement());
  Get.put<MapRepository>(MapRepositoryImplement(mapDataSource: Get.find<MapDataSource>()));

  Get.put<GetAddressFromLatLngUseCase>(GetAddressFromLatLngUseCase(repository: Get.find<MapRepository>()));

  // Orders
  Get.put<OrderDataSource>(OrderDataSourceImplement());
  Get.put<OrderRepository>(OrderRepositoryImplement(orderDataSource: Get.find<OrderDataSource>()));

  Get.put<PlaceOrderUseCase>(PlaceOrderUseCase(repository: Get.find<OrderRepository>()));
  Get.put<CalculateDeliveryFeeUseCase>(CalculateDeliveryFeeUseCase(repository: Get.find<OrderRepository>()));
  Get.put<OrderDetailUseCase>(OrderDetailUseCase(repository: Get.find<OrderRepository>()));
  Get.put<AllOrdersUseCase>(AllOrdersUseCase(repository: Get.find<OrderRepository>()));
  Get.put<DeleteOrderUseCase>(DeleteOrderUseCase(repository: Get.find<OrderRepository>()));
}
