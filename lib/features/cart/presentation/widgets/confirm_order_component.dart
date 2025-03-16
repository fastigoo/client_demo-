import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:learning/core/components/inputs/input_component.dart';
import 'package:learning/core/resources/constants.dart';
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
              hint: 'Ex: 0555555555',
              label: 'Phone number',
              isLabelOutside: true,
              filled: true,
              fillColor: MainColors.backgroundColor(context),
              borderRadius: kRadiusSmall,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: kSpacingMedium,
                vertical: kSpacingXSmall,
              ),
              validate: Validators.compose([
                Validators.required('Phone number is required'),
                Validators.patternString(
                  r'^[0-9]{10}$',
                  'Phone number must be 10 digits',
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
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: 122,
                    height: 45.h,
                    decoration: BoxDecoration(
                      color: MainColors.backgroundColor(context),
                      borderRadius: BorderRadius.circular(kRadiusSmall),
                    ),
                    child: Center(
                      child: Text(
                        'Current Location',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: MainColors.disableColor(context),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: kSpacingSmall),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MainColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kRadiusSmall),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: kSpacingSmall,
                    ),
                    minimumSize: Size(45.w, 45.h),
                  ),
                  child: FaIcon(
                    FontAwesomeIcons.locationDot,
                    color: Colors.white,
                    size: 20.r,
                  ),
                ),
              ],
            ),
            const SizedBox(height: kSpacingSmall),
            Container(
              padding: const EdgeInsets.all(kSpacingSmall),
              decoration: BoxDecoration(
                color: MainColors.secondColor.withOpacity(.1),
                borderRadius: BorderRadius.circular(kRadiusSmall),
                border: Border.all(
                  color: MainColors.secondColor.withOpacity(.3),
                  width: 2.r,
                ),
              ),
              child: Text(
                'keep in mind that Your order will be delivered to your current location if you don\'t change it',
                style: TextStyle(
                  color: MainColors.disableColor(context),
                  fontSize: 12.sp,
                ),
              ),
            ),
            const SizedBox(height: kSpacingSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Distance",
                  style: TextStyles.mediumLabelTextStyle(context).copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  "${deliveryFeeEntity.distance} m",
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
                      "Items",
                      style: TextStyles.mediumLabelTextStyle(context).copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      "${controller.getTotalPrice()} DA",
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
              }
            ),
            const SizedBox(height: kSpacingSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Delivery fee",
                  style: TextStyles.mediumLabelTextStyle(context).copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  "${deliveryFeeEntity.deliveryFee} ${deliveryFeeEntity.currency}",
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
                      "Total",
                      style: TextStyles.mediumLabelTextStyle(context).copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      "${controller.getTotalPrice() + deliveryFeeEntity.deliveryFee} ${deliveryFeeEntity.currency}",
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
              }
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
                            'Confirm Order',
                            style: TextStyle(
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
