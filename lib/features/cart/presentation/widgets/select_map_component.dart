import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/resources/language_strings.dart';
import 'package:learning/core/styles/main_colors.dart';
import 'package:learning/features/cart/presentation/states/cart_controller.dart';
import 'package:learning/routes/app_pages.dart';

class SelectMapPopupComponent extends StatelessWidget {
  const SelectMapPopupComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<CartController>(),
      builder: (controller) {
        return Container(
          padding: const EdgeInsets.all(kSpacingSmall),
          margin: EdgeInsets.all(kSpacingSmall.r),
          decoration: BoxDecoration(
            color: MainColors.cardColor(context),
            borderRadius: BorderRadius.circular(kRadiusMedium.r),
          ),
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
              SizedBox(height: kSpacingSmall.h),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: 122,
                      height: 45.h,
                      decoration: BoxDecoration(
                        color: MainColors.inputColor(context),
                        borderRadius: BorderRadius.circular(kRadiusSmall),
                      ),
                      child: Center(
                        child: Text(
                          LanguageStrings.currentLocation,
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
                    onPressed: () {
                      Get.toNamed(Routes.MAP);
                    },
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
                width: 1.sw,
                decoration: BoxDecoration(
                  color: MainColors.warningColor(context)!.withOpacity(.2),
                  borderRadius: BorderRadius.circular(kRadiusSmall),
                  border: Border.all(
                    color: MainColors.warningColor(context)!.withOpacity(.4),
                    width: 2.r,
                  ),
                ),
                child: Text(
                  // 'keep in mind that Your order will be delivered to your current location if you don\'t change it',
                  LanguageStrings.chooseLocationTitle,
                  style: TextStyle(
                    color: MainColors.disableColor(context),
                    fontSize: 14.sp,
                  ),
                ),
              ),
              const SizedBox(height: kSpacingSmall),
              Obx(
                () => controller.isPlacingOrder.isFalse
                    ? ElevatedButton(
                        onPressed: () {
                          controller.calculateOrderDeliveryFee();
                          Get.back();
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
                          LanguageStrings.confirmLocation,
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
              ),
            ],
          ),
        );
      },
    );
  }
}
