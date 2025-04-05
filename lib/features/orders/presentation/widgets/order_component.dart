import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learning/core/components/popups/confirm_popup.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/styles/main_colors.dart';
import 'package:learning/core/styles/text_styles.dart';
import 'package:learning/features/orders/domain/entities/normal_order_entity.dart';
import 'package:learning/features/orders/presentation/states/orders_controller.dart';

class OrderComponent extends StatelessWidget {
  final NormalOrderEntity normalOrder;
  final OrdersController controller;

  const OrderComponent({
    super.key,
    required this.normalOrder,
    required this.controller,
  });

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
                "ID: #${normalOrder.orderId}",
                style: TextStyles.mediumLabelTextStyle(context),
              ),
              Text(
                normalOrder.createdAt,
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
                  text: normalOrder.restaurantName,
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
                  text: '${normalOrder.city ?? "N/A"}, ${normalOrder.road ?? "N/A"}',
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
                  text: normalOrder.orderStatusValue,
                  style: TextStyles.smallBodyTextStyle(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: MainColors.successColor(context),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: kSpacingSmall.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => ConfirmPopupComponent(
                      title: 'Delete Order',
                      content: 'Are you sure you want to delete this order?',
                      onConfirm: () {
                        controller.deleteOrder(normalOrder.orderId);
                        Navigator.pop(context);
                      },
                      onCancel: () {
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
                child: Row(
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
                    Text("Delete",
                      style: TextStyles.smallBodyTextStyle(context).copyWith(
                        color: MainColors.errorColor(context),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${normalOrder.totalAmount} DZD\$",
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
