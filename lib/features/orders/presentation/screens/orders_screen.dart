import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learning/core/components/loading_animation.dart';
import 'package:learning/core/components/others/back_component.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/resources/language_strings.dart';
import 'package:learning/core/styles/text_styles.dart';
import 'package:learning/features/orders/presentation/states/orders_controller.dart';
import 'package:learning/features/orders/presentation/widgets/order_component.dart';

class OrdersScreen extends GetView<OrdersController> {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: controller,
        builder: (OrdersController controller) {
          return SafeArea(
            child: controller.isLoading.isFalse
                ? SingleChildScrollView(
                    controller: controller.scrollController,
                    padding: EdgeInsets.symmetric(horizontal: kSpacingMedium.w),
                    child: Column(
                      children: [
                        SizedBox(height: kSpacingXSmall.h),
                        Row(
                          children: [
                            const BackComponent(),
                            SizedBox(width: kSpacingMedium.w),
                            Text(
                              LanguageStrings.ordersList,
                              style: TextStyles.mediumLabelTextStyle(context),
                            ),
                          ],
                        ),
                        SizedBox(height: kSpacingMedium.h),
                        ListView.separated(
                          itemBuilder: (c, i) => OrderComponent(
                            normalOrder: controller.orderResEntity.orders[i],
                            controller: controller,
                          ),
                          separatorBuilder: (c, i) => SizedBox(height: kSpacingSmall.h),
                          itemCount: controller.orderResEntity.orders.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                        SizedBox(height: kSpacingMedium.h),
                        Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (controller.isLoadingMore.isFalse) ...{
                                Text.rich(
                                  TextSpan(
                                    text: '${LanguageStrings.totalOrders}: ',
                                    style: TextStyles.smallBodyTextStyle(context),
                                    children: [
                                      TextSpan(
                                        text: controller.orderResEntity.totalOrders.toString(),
                                        style: TextStyles.smallBodyTextStyle(context).copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              } else ...{
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.all(kSpacingMedium.r),
                                    child: SizedBox(
                                      width: 30.w,
                                      height: 30.h,
                                      child: const LoadingAnimation(),
                                    ),
                                  ),
                                ),
                              },
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : const LoadingAnimation(),
          );
        },
      ),
    );
  }
}
