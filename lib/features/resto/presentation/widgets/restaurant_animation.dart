import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/styles/main_colors.dart';
import 'package:shimmer/shimmer.dart';

class RestaurantAnimation extends StatelessWidget {
  const RestaurantAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1.sh * 0.8,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(kSpacingSmall.r),
        child: ListView.separated(
          itemCount: 9,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[200]!,
              highlightColor: Colors.grey[300]!,
              child: Container(
                width: double.infinity,
                height: Random().nextInt(50).h + 160.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kRadiusMedium.r),
                  color: MainColors.cardColor(context),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: kSpacingSmall);
          },
        ),
      ),
    );
  }
}
