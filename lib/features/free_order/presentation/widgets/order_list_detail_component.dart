import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:client/core/resources/constants.dart';
import 'package:client/core/styles/main_colors.dart';
import 'package:client/core/styles/text_styles.dart';
import 'package:client/features/free_order/domain/entities/free_order_item_list_entity.dart';

class OderListDetailComponent extends StatelessWidget {
  final List<FreeOrderItemListEntity> freeOrderItemList;

  const OderListDetailComponent({super.key, required this.freeOrderItemList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: kSpacingMedium.h),
        ListView.separated(
          itemBuilder: (c, i) => Container(
            decoration: BoxDecoration(
              color: MainColors.cardColor(context),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: MainColors.blackColor.withOpacity(.1),
                width: 1,
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: kSpacingMedium.r,
              vertical: kSpacingSmall.r,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  freeOrderItemList[i].name,
                  style: TextStyles.mediumBodyTextStyle(context),
                ),
                Text(
                  "${freeOrderItemList[i].quantity} ${freeOrderItemList[i].unit}",
                  style: TextStyles.mediumBodyTextStyle(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: MainColors.primaryColor,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          separatorBuilder: (c, i) => SizedBox(height: kSpacingSmall.h),
          itemCount: freeOrderItemList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        ),
      ],
    );
  }
}
