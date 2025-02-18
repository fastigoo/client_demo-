import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning/features/resto/domain/entities/restaurant_entity.dart';
import 'package:learning/features/resto/domain/entities/restaurants_entity.dart';
import 'package:learning/features/resto/domain/usecases/all_restaurant_usecase.dart';

class RestoController extends GetxController {
  ScrollController scrollController = ScrollController();
  final RxList<RestaurantEntity> _restaurants = <RestaurantEntity>[].obs;

  List<RestaurantEntity> get getRestaurantsList => _restaurants;

  final _allRestaurantUsecase = Get.find<AllRestaurantUsecase>();

  RxBool isLoading = false.obs;

  final searchController = TextEditingController();

  // Pagination
  int page = 1;
  int perPage = 10;
  int maxPage = 1;

  Timer? _debounceTimer;

  void onSearchChanged() {
    if (_debounceTimer != null) {
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(const Duration(seconds: 2), () {
      searchRestaurants();
    });
  }

  // init
  @override
  void onInit() {
    super.onInit();
    getRestaurants();
  }

  void onScroll() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (isLoading.value) return;
      if (page <= maxPage) getRestaurants();
    }
  }

  void refreshData() {
    page = 1;
    _restaurants.clear();
    getRestaurants();
  }

  void getRestaurants() async {
    try {
      isLoading.value = true;
      var response = await _allRestaurantUsecase.execute(page: page, perPage: perPage);
      response.fold(
        (l) {
          print(l);
        },
        (RestaurantsEntity restos) {
          page += 1;
          maxPage = (restos.totalCount / perPage).ceil();
          _restaurants.addAll(restos.restaurants);
        },
      );
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void searchRestaurants() async {
    page = 1;
    _restaurants.clear();
    try {
      isLoading.value = true;
      var response = await _allRestaurantUsecase.execute(page: page, perPage: perPage, name: searchController.text);
      response.fold(
        (l) {
          print(l);
        },
        (RestaurantsEntity restos) {
          page += 1;
          maxPage = (restos.totalCount / perPage).ceil();
          _restaurants.addAll(restos.restaurants);
        },
      );
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
