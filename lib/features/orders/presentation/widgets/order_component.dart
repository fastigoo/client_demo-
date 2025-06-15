import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:client/core/components/popups/confirm_popup.dart';
import 'package:client/core/resources/constants.dart';
import 'package:client/core/resources/language_strings.dart';
import 'package:client/core/styles/main_colors.dart';
import 'package:client/core/styles/text_styles.dart';
import 'package:client/features/cart/presentation/states/place_order_controller.dart';
import 'package:client/features/orders/domain/entities/normal_order_entity.dart';
import 'package:client/features/orders/presentation/states/orders_controller.dart';
import 'package:client/routes/app_pages.dart';

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
    return GestureDetector(
      onTap: () async {
        Get.toNamed(Routes.PLACE_ORDER, arguments: normalOrder.orderId);
        await Get.put(PlaceOrderController()).getOrderDetail();
      },
      child: Container(
        padding: EdgeInsets.all(kSpacingMedium.r),
        decoration: BoxDecoration(
          color: MainColors.cardColor(context),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${LanguageStrings.id}: #${normalOrder.orderId}",
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
                text: '${LanguageStrings.restaurant}: ',
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
                text: '${LanguageStrings.location}: ',
                style: TextStyles.smallBodyTextStyle(context),
                children: [
                  TextSpan(
                    text: '${normalOrder.city ?? LanguageStrings.nA}, ${normalOrder.road ?? LanguageStrings.nA}',
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
                text: '${LanguageStrings.status}: ',
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
                        title: '${LanguageStrings.delete} ${LanguageStrings.order}',
                        content: LanguageStrings.deleteOrderMessage,
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
                      Text(
                        LanguageStrings.delete,
                        style: TextStyles.smallBodyTextStyle(context).copyWith(
                          color: MainColors.errorColor(context),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "${normalOrder.totalAmount} ${LanguageStrings.dzd}",
                  style: TextStyles.mediumBodyTextStyle(context).copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
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
