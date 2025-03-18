import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learning/core/components/others/back_component.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/styles/text_styles.dart';
import 'package:learning/features/orders/presentation/states/orders_controller.dart';
import 'package:learning/features/orders/presentation/widgets/order_component.dart';

class OrdersScreen extends GetView<OrdersController> {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: kSpacingMedium.w),
          child: Column(
            children: [
              Row(
                children: [
                  const BackComponent(),
                  SizedBox(width: kSpacingMedium.w),
                  Text(
                    'Orders',
                    style: TextStyles.mediumLabelTextStyle(context),
                  ),
                ],
              ),
              SizedBox(height: kSpacingMedium.h),
              ListView.separated(
                itemBuilder: (c, i) => const OrderComponent(),
                separatorBuilder: (c, i) => SizedBox(height: kSpacingSmall.h),
                itemCount: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
              SizedBox(height: kSpacingMedium.h),
              Text.rich(
                TextSpan(
                  text: 'Total Orders: ',
                  style: TextStyles.smallBodyTextStyle(context),
                  children: [
                    TextSpan(
                      text: '10',
                      style: TextStyles.smallBodyTextStyle(context).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
