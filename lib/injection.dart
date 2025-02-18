import 'package:get/get.dart';
import 'package:learning/features/resto/data/datasources/restaurant_data_source.dart';
import 'package:learning/features/resto/data/repositories/restaurant_repository_implement.dart';
import 'package:learning/features/resto/domain/repositories/restaurant_repository.dart';
import 'package:learning/features/resto/domain/usecases/all_restaurant_usecase.dart';

Future<void> injectionInit() async {

  // Restaurant
  Get.put<RestaurantDataSource>(RestaurantDataSourceImplement());
  Get.put<RestaurantRepository>(RestaurantRepositoryImplement(remote: Get.find<RestaurantDataSource>()));

  Get.put<AllRestaurantUsecase>(AllRestaurantUsecase(repository: Get.find<RestaurantRepository>()));


}
