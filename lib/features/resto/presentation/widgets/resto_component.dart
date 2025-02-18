import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/services/resource_manager.dart';
import 'package:learning/core/styles/main_colors.dart';
import 'package:learning/core/styles/text_styles.dart';
import 'package:learning/features/home/presentation/screens/home_screen.dart';
import 'package:learning/features/resto/domain/entities/restaurant_entity.dart';

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
        Get.to(() => const HomeScreen());
      },
      child: Container(
        padding: EdgeInsets.all(kSpacingSmall.r),
        decoration: BoxDecoration(
          color: MainColors.cardColor(context),
          borderRadius: BorderRadius.circular(kRadiusMedium.r / 2),
          border: Border.all(
            color: Colors.grey.withOpacity(.2),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(kRadiusSmall.r / 1.5),
              child: Hero(
                tag: item.imageUrl,
                child: Image.network(
                  ResourceManager.getNetworkResource(item.imageUrl),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: kSpacingSmall.h),
            Text(
              item.name,
              style: TextStyles.mediumBodyTextStyle(context).copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Status: ",
                    style: TextStyles.smallBodyTextStyle(context).copyWith(
                      color: Colors.grey,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: item.isOpen ? "open" : "closed",
                        style: TextStyles.smallBodyTextStyle(context).copyWith(
                          color: item.isOpen ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: kSpacingXSmall.r,
                    vertical: kSpacingXSmall.r,
                  ),
                  decoration: BoxDecoration(
                    color: item.isOpen ? Colors.green : Colors.grey,
                    borderRadius: BorderRadius.circular(kRadiusSmall.r),
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
