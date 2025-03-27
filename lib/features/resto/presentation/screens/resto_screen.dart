import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:learning/core/components/inputs/input_component.dart';
import 'package:learning/core/resources/constants.dart';
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
      // backgroundColor: MainColors.backgroundColor(context),
      body: SafeArea(
        child: Obx(
          () => RefreshIndicator(
            onRefresh: () async {
              controller.refreshData();
            },
            child: Scrollbar(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: kSpacingMedium.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            FaIcon(FontAwesomeIcons.mapLocation, size: 20.r),
                            SizedBox(width: kSpacingSmall.r),
                            Text(
                              "Mila, Mila, Algeria",
                              style: TextStyles.mediumBodyTextStyle(context),
                            ),
                          ],
                        ),
                        StorageManager.instance.getIntValue(key: StorageKey.userIdKey) != 0
                            ? GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.ORDERS);
                                },
                                child: Container(
                                  width: 50.r,
                                  height: 50.r,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: MainColors.whiteColor,
                                  ),
                                  child: Center(
                                    child: FaIcon(
                                      FontAwesomeIcons.ellipsis,
                                      color: MainColors.primaryColor,
                                      size: 20.r,
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 50.r,
                                width: 50.r,
                              ),
                      ],
                    ),
                    SizedBox(height: kSpacingMedium.r),
                    Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: MainColors.primaryColor,
                        borderRadius: BorderRadius.circular(kRadiusMedium.r),
                      ),
                      padding: EdgeInsets.all(kSpacingMedium.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.plus,
                                size: 20.r,
                                color: Colors.white,
                              ),
                              SizedBox(width: kSpacingSmall.r),
                              Text(
                                "Free order",
                                style: TextStyles.mediumLabelTextStyle(context).copyWith(
                                  color: MainColors.whiteColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'In case you have an order outside of the existing stores in the app, you can create a free order and we will make sure to delivery it as soon as possible',
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
                              padding: EdgeInsets.all(kSpacingMedium.r - 3),
                              decoration: BoxDecoration(
                                color: MainColors.secondColor,
                                borderRadius: BorderRadius.circular(kRadiusSmall.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Free order",
                                    style: TextStyles.smallLabelTextStyle(context).copyWith(
                                      color: MainColors.primaryColor,
                                    ),
                                  ),
                                  FaIcon(FontAwesomeIcons.chevronRight, size: 20.r),
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
                              hint: "Search for a restaurant ...",
                              contentPadding: EdgeInsets.symmetric(horizontal: kSpacingMedium.r, vertical: kSpacingMedium.r),
                              borderRadius: kRadiusMedium.r,
                              onChange: (value) {
                                controller.onSearchChanged();
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: kSpacingSmall.r),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: kSpacingMedium.r, vertical: kSpacingMedium.r),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(kRadiusMedium.r),
                            color: MainColors.primaryColor,
                          ),
                          child: Center(
                            child: FaIcon(
                              FontAwesomeIcons.magnifyingGlass,
                              color: MainColors.whiteColor,
                              size: 20.r,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: kSpacingMedium.r),
                    SizedBox(
                      height: 50.r,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (c, i) => Container(
                          padding: EdgeInsets.symmetric(horizontal: kSpacingMedium.r),
                          decoration: BoxDecoration(
                            color: i == 0 ? MainColors.primaryColor : MainColors.whiteColor,
                            borderRadius: BorderRadius.circular(kRadiusMedium.r),
                          ),
                          child: Row(
                            children: [
                              FaIcon(
                                controller.categoriesList[i].image,
                                size: 20.r,
                                color: i == 0 ? MainColors.whiteColor : MainColors.primaryColor,
                              ),
                              SizedBox(width: kSpacingSmall.r),
                              Text(
                                controller.categoriesList[i].name,
                                style: TextStyles.smallLabelTextStyle(context).copyWith(
                                  color: i == 0 ? MainColors.whiteColor : MainColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        separatorBuilder: (c, i) => SizedBox(width: kSpacingSmall.w),
                        itemCount: controller.categoriesList.length,
                      ),
                    ),
                    SizedBox(height: kSpacingMedium.r),
                    Container(
                      margin: EdgeInsets.only(bottom: kSpacingMedium.r),
                      constraints: BoxConstraints(
                        minHeight: Get.height,
                      ),
                      child: controller.isLoading.isFalse
                          ? ListView.separated(
                              itemBuilder: (c, i) => RestoComponent(
                                item: controller.getRestaurantsList[i],
                              ),
                              separatorBuilder: (c, i) => SizedBox(height: kSpacingSmall.h),
                              itemCount: controller.getRestaurantsList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                            )
                          : const RestaurantAnimation(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
