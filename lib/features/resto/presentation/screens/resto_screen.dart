import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:learning/core/components/empty_component.dart';
import 'package:learning/core/components/inputs/input_component.dart';
import 'package:learning/core/helper/translation_util.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/resources/language_strings.dart';
import 'package:learning/core/resources/storage_keys.dart';
import 'package:learning/core/services/storage_manager.dart';
import 'package:learning/core/styles/text_styles.dart';
import 'package:learning/features/resto/presentation/states/resto_controller.dart';
import 'package:learning/features/resto/presentation/widgets/restaurant_animation.dart';
import 'package:learning/features/resto/presentation/widgets/resto_component.dart';
import 'package:learning/routes/app_pages.dart';
import 'package:learning/core/styles/main_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestoScreen extends GetView<RestoController> {
  const RestoScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => RefreshIndicator(
            onRefresh: () async {
              controller.refreshData();
            },
            child: SingleChildScrollView(
              controller: controller.scrollController,
              padding: EdgeInsets.symmetric(horizontal: kSpacingMedium.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: kSpacingSmall.r),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          FaIcon(FontAwesomeIcons.mapPin, size: 20.r),
                          SizedBox(width: kSpacingSmall.r),
                          Text(
                            LanguageStrings.milaAlgeria,
                            style: TextStyles.mediumBodyTextStyle(context),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          StorageManager.instance.getIntValue(key: StorageKey.userIdKey) != 0
                              ? GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.ORDERS);
                                  },
                                  child: Container(
                                    width: 50.r,
                                    height: 50.r,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: MainColors.cardColor(context),
                                    ),
                                    child: Center(
                                      child: FaIcon(
                                        FontAwesomeIcons.file,
                                        size: 20.r,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          SizedBox(width: kSpacingSmall.r),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.SETTINGS);
                            },
                            child: Container(
                              width: 50.r,
                              height: 50.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MainColors.cardColor(context),
                              ),
                              child: Center(
                                child: FaIcon(
                                  FontAwesomeIcons.gears,
                                  size: 20.r,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: kSpacingMedium.r),
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: MainColors.primaryColor,
                      borderRadius: BorderRadius.circular(kRadiusSmall.r),
                    ),
                    padding: EdgeInsets.all(kSpacingMedium.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.squarePlus,
                              size: 20.r,
                              color: Colors.white,
                            ),
                            SizedBox(width: kSpacingSmall.r),
                            Text(
                              LanguageStrings.freeOrder,
                              style: TextStyles.mediumLabelTextStyle(context).copyWith(
                                color: MainColors.whiteColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          LanguageStrings.freeOrderDescription,
                          style: TextStyles.smallBodyTextStyle(context).copyWith(
                            color: MainColors.whiteColor,
                          ),
                        ),
                        SizedBox(height: kSpacingMedium.r),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.FREE_ORDER);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: kSpacingMedium.r, vertical: kSpacingMedium.r),
                            decoration: BoxDecoration(
                              color: MainColors.secondColor,
                              borderRadius: BorderRadius.circular(kRadiusSmall.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  LanguageStrings.freeOrder,
                                  style: TextStyles.smallLabelTextStyle(context).copyWith(
                                    color: MainColors.whiteColor,
                                  ),
                                ),
                                FaIcon(
                                  TranslationUtil.isRtl() ? FontAwesomeIcons.chevronLeft : FontAwesomeIcons.chevronRight,
                                  size: 16.r,
                                  color: MainColors.whiteColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: kSpacingMedium.r),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(kRadiusMedium.r),
                          ),
                          child: TextInputComponent(
                            controller: controller.searchController,
                            hint: LanguageStrings.searchInputHint,
                            contentPadding: EdgeInsets.symmetric(horizontal: kSpacingMedium.r, vertical: kSpacingMedium.r),
                            borderRadius: kRadiusSmall.r,
                            onChange: (value) {
                              controller.onSearchChanged();
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: kSpacingSmall.r),
                      GestureDetector(
                        onTap: () {
                          controller.searchRestaurants();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: kSpacingMedium.r, vertical: kSpacingMedium.r),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(kRadiusSmall.r),
                            color: MainColors.primaryColor,
                          ),
                          child: Center(
                            child: FaIcon(
                              FontAwesomeIcons.magnifyingGlass,
                              color: MainColors.whiteColor,
                              size: 17.r,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: kSpacingMedium.r),
                  Container(
                    margin: EdgeInsets.only(bottom: kSpacingMedium.r),
                    constraints: BoxConstraints(
                      minHeight: controller.getRestaurantsList.isNotEmpty ? Get.height : 400.h,
                    ),
                    child: controller.isLoading.isFalse
                        ? controller.getRestaurantsList.isNotEmpty
                            ? GetBuilder(
                                init: controller,
                                id: StorageKey.allRestaurantsKey,
                                builder: (controller) {
                                  return ListView.separated(
                                    itemBuilder: (c, i) => RestoComponent(
                                      item: controller.getRestaurantsList[i],
                                    ),
                                    separatorBuilder: (c, i) => SizedBox(height: kSpacingLarge.h),
                                    itemCount: controller.getRestaurantsList.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                  );
                                },
                              )
                            : SizedBox(
                                height: 400.h,
                                child: GestureDetector(
                                  onTap: () {
                                    controller.refreshData();
                                  },
                                  child: EmptyComponent(
                                    text: LanguageStrings.noDataFound,
                                  ),
                                ),
                              )
                        : const RestaurantAnimation(),
                  ),
                  Obx(
                    () => Center(
                      child: controller.isLoadingMore.isTrue
                          ? Padding(
                              padding: EdgeInsets.only(bottom: kSpacingMedium.h, top: kSpacingMedium.h),
                              child: CircularProgressIndicator(
                                color: MainColors.primaryColor,
                                strokeWidth: 2.r,
                              ),
                            )
                          : const SizedBox(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
