import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning/core/helper/utils.dart';
import 'package:learning/core/resources/language_strings.dart';
import 'package:learning/core/resources/storage_keys.dart';
import 'package:learning/features/resto/domain/entities/restaurant_entity.dart';
import 'package:learning/features/resto/domain/entities/restaurants_entity.dart';
import 'package:learning/features/resto/domain/usecases/all_restaurant_usecase.dart';

class RestoController extends GetxController {
  ScrollController scrollController = ScrollController();
  final RxList<RestaurantEntity> _restaurants = <RestaurantEntity>[].obs;

  List<RestaurantEntity> get getRestaurantsList => _restaurants;

  final _allRestaurantUsecase = Get.find<AllRestaurantUsecase>();

  RxBool isLoading = false.obs;
  RxBool isLoadingMore = false.obs;

  final searchController = TextEditingController();

  // Pagination
  int page = 1;
  int perPage = 15;
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

  @override
  void onInit() {
    super.onInit();
    getRestaurants();
    scrollController.addListener(() {
      if (_shouldLoadMore()) {
        loadMoreRestaurants();
      }
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    _debounceTimer?.cancel();
    super.onClose();
  }

  bool _shouldLoadMore() {
    return !isLoadingMore.value &&
        page <= maxPage &&
        scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200;
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
          showToast(message: l.toString());
        },
        (RestaurantsEntity restos) {
          maxPage = (restos.totalCount / perPage).ceil();
          _restaurants.addAll(restos.restaurants);
          update([StorageKey.allRestaurantsKey]);
        },
      );
    } catch (e) {
      showToast(message: LanguageStrings.somethingWentWrong);
    } finally {
      isLoading.value = false;
    }
  }

  void loadMoreRestaurants() async {
    if (!isLoadingMore.value) {
      if (page < maxPage) {
        page++;
        try {
          isLoadingMore.value = true;
          var response = await _allRestaurantUsecase.execute(
            page: page,
            perPage: perPage,
          );
          response.fold(
            (l) {
              showToast(message: l.toString());
            },
            (value) async {
              _restaurants.addAll(value.restaurants);
              update([StorageKey.allRestaurantsKey]);
            },
          );
        } catch (e) {
          showToast(message: LanguageStrings.somethingWentWrong);
        } finally {
          isLoadingMore.value = false;
        }
      }
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
          showToast(message: l.toString());
        },
        (RestaurantsEntity restos) {
          _restaurants.addAll(restos.restaurants);
          maxPage = (restos.totalCount / perPage).ceil();
          update([StorageKey.allRestaurantsKey]);
        },
      );
    } catch (e) {
      showToast(message: LanguageStrings.somethingWentWrong);
    } finally {
      isLoading.value = false;
    }
  }
}

class CategoryTest {
  final String name;
  final IconData image;

  CategoryTest({
    required this.name,
    required this.image,
  });
}
