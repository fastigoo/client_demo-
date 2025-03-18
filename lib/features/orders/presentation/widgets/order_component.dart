import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/styles/main_colors.dart';
import 'package:learning/core/styles/text_styles.dart';

class OrderComponent extends StatelessWidget {
  const OrderComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kSpacingMedium.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ID: #${Random().nextInt(10000)}",
                style: TextStyles.mediumLabelTextStyle(context),
              ),
              Text(
                "12-12-2021 12:12 AM",
                style: TextStyles.smallBodyTextStyle(context).copyWith(
                  color: MainColors.disableColor(context),
                  fontSize: 10.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: kSpacingSmall.h),
          Text.rich(
            TextSpan(
              text: 'Restaurant: ',
              style: TextStyles.smallBodyTextStyle(context),
              children: [
                TextSpan(
                  text: 'King Burger',
                  style: TextStyles.smallBodyTextStyle(context).copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: kSpacingXSmall.h),
          Text.rich(
            TextSpan(
              text: 'Location: ',
              style: TextStyles.smallBodyTextStyle(context),
              children: [
                TextSpan(
                  text: 'in front of the park',
                  style: TextStyles.smallBodyTextStyle(context).copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: kSpacingXSmall.h),
          Text.rich(
            TextSpan(
              text: 'Status: ',
              style: TextStyles.smallBodyTextStyle(context),
              children: [
                TextSpan(
                  text: 'Delivered',
                  style: TextStyles.smallBodyTextStyle(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: MainColors.successColor(context),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: kSpacingXSmall.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: MainColors.errorColor(context),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.trash,
                        color: MainColors.whiteColor,
                        size: 16.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: kSpacingSmall.w),
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: MainColors.successColor(context),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.rotate,
                        color: MainColors.whiteColor,
                        size: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "${Random().nextInt(100)}00 DZD",
                style: TextStyles.mediumBodyTextStyle(context).copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
