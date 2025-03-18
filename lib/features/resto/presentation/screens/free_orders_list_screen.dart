import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:learning/core/components/others/back_component.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/styles/main_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning/core/styles/text_styles.dart';
import 'package:learning/features/resto/presentation/states/free_orders_controller.dart';
import 'package:learning/routes/app_pages.dart';

class FreeOrdersListScreen extends GetView<FreeOrdersController> {
  const FreeOrdersListScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: Get.height - kSpacingMedium.r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BackComponent(),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.FREE_ORDER);
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
                          FontAwesomeIcons.plus,
                          color: MainColors.primaryColor,
                          size: 20.r,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: kSpacingMedium.h),
              Expanded(
                child: ListView.separated(
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return ExpandableOrderItem(index: index);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: kSpacingMedium.h);
                  },
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: kSpacingMedium.r),
        ),
      ),
    );
  }
}

class ExpandableOrderItem extends StatefulWidget {
  final int index;

  const ExpandableOrderItem({Key? key, required this.index}) : super(key: key);

  @override
  _ExpandableOrderItemState createState() => _ExpandableOrderItemState();
}

class _ExpandableOrderItemState extends State<ExpandableOrderItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(kSpacingMedium.r),
        decoration: BoxDecoration(
          color: MainColors.whiteColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 45.r,
                      height: 45.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: MainColors.primaryColor,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.rotate,
                          color: MainColors.primaryColor,
                          size: 20.r,
                        ),
                      ),
                    ),
                    SizedBox(width: kSpacingSmall.w),
                    Container(
                      width: 45.r,
                      height: 45.r,
                      decoration: BoxDecoration(
                        color: MainColors.errorColor(context),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: MainColors.errorColor(context)!,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.xmark,
                          color: MainColors.whiteColor,
                          size: 20.r,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "#${Random().nextInt(200) + 4}",
                  style: TextStyles.mediumLabelTextStyle(context),
                ),
              ],
            ),
            SizedBox(height: kSpacingMedium.h),
            Text(
              "12/12/2023 12:23 PM",
              style: TextStyles.mediumBodyTextStyle(context),
            ),
            SizedBox(height: kSpacingXSmall.h),
            Text(
              "Pending",
              style: TextStyles.mediumBodyTextStyle(context),
            ),
            if (isExpanded) ...[
              SizedBox(height: kSpacingMedium.h),
              ListView.separated(
                itemBuilder: (c, i) => Container(
                  decoration: BoxDecoration(
                    color: MainColors.blackColor.withOpacity(.05),
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
                        "Item ${i + 1}",
                        style: TextStyles.mediumBodyTextStyle(context),
                      ),
                      Text(
                        "1 Kg",
                        style: TextStyles.mediumBodyTextStyle(context),
                      ),
                    ],
                  ),
                ),
                separatorBuilder: (c, i) => SizedBox(height: kSpacingSmall.h),
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
