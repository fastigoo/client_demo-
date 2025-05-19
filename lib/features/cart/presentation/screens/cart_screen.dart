import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learning/core/components/empty_component.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/resources/language_strings.dart';
import 'package:learning/core/styles/main_colors.dart';
import 'package:learning/core/styles/text_styles.dart';
import 'package:learning/features/cart/presentation/states/cart_controller.dart';
import 'package:learning/features/cart/presentation/widgets/cart_component.dart';
import 'package:learning/features/cart/presentation/widgets/select_map_component.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          LanguageStrings.cartScreen,
          style: TextStyles.mediumLabelTextStyle(context).copyWith(
            color: Colors.white,
          ),
        ),
        titleSpacing: 5.w,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        toolbarHeight: 55.h,
      ),
      body: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            children: [
              Expanded(
                child: controller.cartItems.isNotEmpty
                    ? ListView.separated(
                        itemCount: controller.cartItems.length,
                        padding: EdgeInsets.all(kSpacingSmall.r),
                        itemBuilder: (context, index) {
                          return CartComponent(item: controller.cartItems[index]);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: kSpacingSmall.h);
                        },
                      )
                    : EmptyComponent(
                        text: LanguageStrings.cartEmpty,
                      ),
              ),
              SizedBox(height: kSpacingMedium.h),
              if (controller.cartItems.isNotEmpty)
                SafeArea(
                  child: Container(
                    padding: EdgeInsets.all(kSpacingSmall.r),
                    decoration: BoxDecoration(
                      color: MainColors.cardColor(context),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              LanguageStrings.items,
                              style: TextStyles.mediumBodyTextStyle(context).copyWith(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              controller.cartItems.length.toString(),
                              style: TextStyles.mediumLabelTextStyle(context).copyWith(
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.dashed,
                                decorationThickness: 2,
                                fontSize: 18.sp,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              LanguageStrings.total,
                              style: TextStyles.mediumBodyTextStyle(context).copyWith(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${controller.getTotalPrice().toStringAsFixed(2)} ${LanguageStrings.dzd}',
                              style: TextStyles.mediumLabelTextStyle(context).copyWith(
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.dashed,
                                decorationThickness: 2,
                                fontSize: 18.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: kSpacingSmall.h),
                        Obx(
                          () => controller.isPlacingOrder.isFalse
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: MainColors.primaryColor,
                                    minimumSize: Size(double.infinity, 50.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(kRadiusSmall.r),
                                    ),
                                  ),
                                  onPressed: () async {
                                    await controller.onMapCreated();
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      builder: (context) => const SafeArea(child: SelectMapPopupComponent()),
                                    );
                                  },
                                  child: Text(
                                    LanguageStrings.selectAddress,
                                    style: TextStyles.mediumLabelTextStyle(context).copyWith(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 45.h + kSpacingSmall / 2,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: kSpacingSmall,
                                  ),
                                  decoration: BoxDecoration(
                                    color: MainColors.backgroundColor(context),
                                    borderRadius: BorderRadius.circular(kRadiusSmall),
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                      height: 20.h,
                                      width: 20.w,
                                      child: const CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          MainColors.primaryColor,
                                        ),
                                        strokeWidth: 3,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                        SizedBox(height: kSpacingSmall.h),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
