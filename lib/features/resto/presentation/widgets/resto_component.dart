import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learning/core/components/others/network_image_component.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/resources/language_strings.dart';
import 'package:learning/core/services/resource_manager.dart';
import 'package:learning/core/styles/main_colors.dart';
import 'package:learning/core/styles/text_styles.dart';
import 'package:learning/features/home/presentation/screens/home_screen.dart';
import 'package:learning/features/resto/domain/entities/restaurant_entity.dart';
import 'package:learning/routes/app_pages.dart';

class RestoComponent extends StatelessWidget {
  final RestaurantEntity item;

  const RestoComponent({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.HOME,
          arguments: {
            'restaurantId': item.restaurantId,
            'restaurantName': item.name,
          },
        );
      },
      child: Container(
        width: 1.sw,
        decoration: BoxDecoration(
          color: MainColors.cardColor(context),
          borderRadius: BorderRadius.circular(kRadiusSmall.r),
        ),
        child: Column(
          children: [
            SizedBox(
              width: 1.sw,
              height: 200.h,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(kRadiusSmall.r),
                  topRight: Radius.circular(kRadiusSmall.r),
                ),
                child: Hero(
                  tag: item.imageUrl,
                  child: CacheNetworkImageComponent(
                    imageUrl: ResourceManager.getNetworkResource(item.imageUrl),
                  ),
                ),
              ),
            ),
            SizedBox(height: kSpacingXSmall.h),
            Container(
              width: 1.sw,
              height: 40.h,
              padding: EdgeInsets.symmetric(
                horizontal: kSpacingMedium.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(kRadiusSmall.r),
                  bottomRight: Radius.circular(kRadiusSmall.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item.name,
                      style: TextStyles.mediumLabelTextStyle(context).copyWith(
                        fontSize: 16.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: kSpacingSmall.w),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.circle_fill,
                        color: MainColors.successColor(context),
                        size: 12.r,
                      ),
                      SizedBox(width: kSpacingXSmall.w),
                      Text(
                        LanguageStrings.open,
                        style: TextStyles.mediumLabelTextStyle(context).copyWith(
                          color: MainColors.successColor(context),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
