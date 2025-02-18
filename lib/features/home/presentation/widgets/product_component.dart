import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/resources/images.dart';
import 'package:learning/core/services/resource_manager.dart';
import 'package:learning/core/styles/main_colors.dart';
import 'package:learning/core/styles/text_styles.dart';
import 'package:learning/features/home/presentation/screens/product_detail_screen.dart';

class ProductComponent extends StatelessWidget {
  final String imageUrl;
  const ProductComponent({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => const ProductDetailScreen(),
          arguments: {
            "image": imageUrl,
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: MainColors.cardColor(context),
          borderRadius: BorderRadius.circular(kRadiusMedium.r / 2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.3),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Product Name",
              style: TextStyles.mediumBodyTextStyle(context).copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "${Random().nextInt(10) + 1}00 DA",
              style: TextStyles.mediumLabelTextStyle(context).copyWith(
                fontSize: 18.sp,
                color: MainColors.primaryColor,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dashed,
                decorationColor: MainColors.primaryColor,
              ),
            ),
            SizedBox(height: 5.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(kRadiusSmall.r),
              child: Hero(
                tag: imageUrl,
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: kSpacingSmall.r),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: MainColors.primaryColor,
                      borderRadius: BorderRadius.circular(kRadiusSmall.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          ResourceManager.getAssetResource(
                            addCartIcon,
                            type: ResourceType.svg,
                          ),
                          width: 15.w,
                          colorFilter: const ColorFilter.mode(
                            MainColors.whiteColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          "Add to cart",
                          style: TextStyles.mediumBodyTextStyle(context).copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: kSpacingSmall.r),
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: MainColors.primaryColor.withOpacity(.1),
                    borderRadius: BorderRadius.circular(kRadiusSmall.r),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      ResourceManager.getAssetResource(
                        heartIcon,
                        type: ResourceType.svg,
                      ),
                      width: 20.w,
                      colorFilter: const ColorFilter.mode(
                        MainColors.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
