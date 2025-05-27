import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learning/core/components/inputs/input_component.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/resources/language_strings.dart';
import 'package:learning/core/styles/main_colors.dart';
import 'package:learning/core/styles/text_styles.dart';
import 'package:learning/features/cart/domain/entities/delivery_fee_entity.dart';
import 'package:learning/features/cart/presentation/states/cart_controller.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class ConfirmOrderComponent extends StatelessWidget {
  final TextEditingController phoneController;
  final GlobalKey<FormState> formKey;
  final DeliveryFeeEntity deliveryFeeEntity;

  const ConfirmOrderComponent({
    required this.phoneController,
    required this.formKey,
    required this.deliveryFeeEntity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kSpacingSmall),
      margin: EdgeInsets.all(kSpacingSmall.r),
      decoration: BoxDecoration(
        color: MainColors.cardColor(context),
        borderRadius: BorderRadius.circular(kRadiusMedium.r),
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 100.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: MainColors.primaryColor.withOpacity(.3),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: kSpacingSmall),
            TextInputComponent(
              hint: LanguageStrings.phoneNumberHint,
              label: LanguageStrings.phoneNumber,
              isLabelOutside: true,
              filled: true,
              fillColor: MainColors.backgroundColor(context),
              borderRadius: kRadiusSmall,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: kSpacingMedium,
                vertical: kSpacingXSmall,
              ),
              validate: Validators.compose([
                Validators.required(LanguageStrings.phoneNumberIsRequired),
                Validators.patternString(
                  r'^[0-9]{10}$',
                  LanguageStrings.phoneNumberIsNotValid,
                ),
              ]),
              controller: phoneController,
              textInputType: TextInputType.phone,
              suffix: SizedBox(
                width: 30,
                child: Icon(
                  Icons.phone,
                  size: 20,
                  color: MainColors.disableColor(context)!,
                ),
              ),
            ),
            const SizedBox(height: kSpacingSmall),
            Container(
              padding: const EdgeInsets.all(kSpacingSmall),
              width: 1.sw,
              decoration: BoxDecoration(
                color: MainColors.secondColor.withOpacity(.2),
                borderRadius: BorderRadius.circular(kRadiusSmall),
                border: Border.all(
                  color: MainColors.secondColor.withOpacity(.3),
                  width: 2.r,
                ),
              ),
              child: Text(
                LanguageStrings.chooseLocationTitle,
                style: TextStyle(
                  color: MainColors.disableColor(context),
                  fontSize: 14.sp,
                ),
              ),
            ),
            const SizedBox(height: kSpacingSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LanguageStrings.distance,
                  style: TextStyles.mediumLabelTextStyle(context).copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  "${deliveryFeeEntity.getNormalizedDistance().toStringAsFixed(2)} ${deliveryFeeEntity.isNormalizedDistance() ? LanguageStrings.kg : LanguageStrings.m}",
                  style: TextStyles.mediumBodyTextStyle(context).copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: MainColors.primaryColor,
                    decorationStyle: TextDecorationStyle.dashed,
                    decorationThickness: 3,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: MainColors.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: kSpacingSmall),
            GetBuilder(
                init: Get.find<CartController>(),
                builder: (controller) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LanguageStrings.items,
                        style: TextStyles.mediumLabelTextStyle(context).copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      Text(
                        "${controller.getTotalPrice().toStringAsFixed(2)} ${LanguageStrings.dzd}",
                        style: TextStyles.mediumBodyTextStyle(context).copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: MainColors.primaryColor,
                          decorationStyle: TextDecorationStyle.dashed,
                          decorationThickness: 3,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: MainColors.primaryColor,
                        ),
                      ),
                    ],
                  );
                },),
            const SizedBox(height: kSpacingSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LanguageStrings.deliveryFee,
                  style: TextStyles.mediumLabelTextStyle(context).copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  "${deliveryFeeEntity.deliveryFee.toStringAsFixed(2)} ${LanguageStrings.dzd}",
                  style: TextStyles.mediumBodyTextStyle(context).copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: MainColors.primaryColor,
                    decorationStyle: TextDecorationStyle.dashed,
                    decorationThickness: 3,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: MainColors.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: kSpacingSmall),
            GetBuilder(
              init: Get.find<CartController>(),
              builder: (controller) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LanguageStrings.total,
                      style: TextStyles.mediumLabelTextStyle(context).copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      "${(controller.getTotalPrice() + deliveryFeeEntity.deliveryFee).toStringAsFixed(2)} ${LanguageStrings.dzd}",
                      style: TextStyles.mediumBodyTextStyle(context).copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: MainColors.primaryColor,
                        decorationStyle: TextDecorationStyle.dashed,
                        decorationThickness: 3,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: MainColors.primaryColor,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: kSpacingSmall),
            GetBuilder(
              init: Get.find<CartController>(),
              builder: (controller) {
                return Obx(
                  () => controller.isPlacingOrder.isFalse
                      ? ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              controller.placeOrder(
                                deliveryFee: deliveryFeeEntity.deliveryFee,
                                distance: deliveryFeeEntity.distance,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MainColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(kRadiusSmall),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: kSpacingSmall,
                            ),
                            minimumSize: Size(double.infinity, 45.h),
                          ),
                          child: Text(
                            LanguageStrings.confirmOrder,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.sp,
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
