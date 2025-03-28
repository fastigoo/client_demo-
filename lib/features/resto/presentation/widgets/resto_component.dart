import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learning/core/resources/constants.dart';
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
        Get.toNamed(Routes.HOME, arguments: item.restaurantId);
      },
      child: Container(
        width: 1.sw,
        decoration: BoxDecoration(
          color: MainColors.cardColor(context),
          borderRadius: BorderRadius.circular(kRadiusMedium.r),
          border: Border.all(
            color: Colors.grey.withOpacity(.2),
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            SizedBox(
              width: 1.sw,
              height: 200.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(kRadiusSmall.r),
                child: Hero(
                  tag: item.imageUrl,
                  child: Image.network(
                    ResourceManager.getNetworkResource(item.imageUrl),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10.h,
              left: 10.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(kRadiusSmall.r),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    width: 1.sw - 55.r,
                    padding: EdgeInsets.symmetric(
                      horizontal: kSpacingMedium.w,
                      vertical: kSpacingSmall.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kRadiusSmall.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.name,
                          style: TextStyles.mediumLabelTextStyle(context).copyWith(
                            color: MainColors.whiteColor,
                            fontSize: 16.sp,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.circle_fill,
                              color: MainColors.successColor(context),
                              size: 12.r,
                            ),
                            SizedBox(width: kSpacingXSmall.w),
                            Text(
                              "Open",
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
