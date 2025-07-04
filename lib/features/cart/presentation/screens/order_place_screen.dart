import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:client/core/components/others/dashed_rect.dart';
import 'package:client/core/components/phone_numbers_component.dart';
import 'package:client/core/resources/constants.dart';
import 'package:client/core/resources/images.dart';
import 'package:client/core/resources/language_strings.dart';
import 'package:client/core/resources/states_ids.dart';
import 'package:client/core/services/resource_manager.dart';
import 'package:client/core/styles/main_colors.dart';
import 'package:client/core/styles/text_styles.dart';
import 'package:client/features/cart/presentation/states/place_order_controller.dart';
import 'package:client/routes/app_pages.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceOrderScreen extends GetView<PlaceOrderController> {
  const PlaceOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.cardColor(context),
      body: GetBuilder(
        init: controller,
        id: StatesIds.orderDetail,
        builder: (controller) {
          return Obx(
            () => SafeArea(
              child: controller.isLoading.isFalse
                  ? Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(kSpacingMedium.r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: "${LanguageStrings.orderID}: ",
                                  style: TextStyles.mediumLabelTextStyle(context).copyWith(
                                    color: MainColors.primaryColor,
                                    fontSize: 15.sp,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: controller.orderDetail!.orderId.toString(),
                                      style: TextStyles.mediumLabelTextStyle(context).copyWith(
                                        color: MainColors.disableColor(context),
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.offAndToNamed(Routes.RESTO);
                                },
                                child: Container(
                                  height: 45.r,
                                  width: 45.r,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: MainColors.textColor(context)!,
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: FaIcon(
                                      FontAwesomeIcons.xmark,
                                      color: MainColors.textColor(context),
                                      size: 20.r,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Lottie.asset(
                            ResourceManager.getAssetResource(
                              "waiting.json",
                              type: ResourceType.image,
                            ),
                            width: 200.h,
                            height: 200.w,
                          ),
                        ),
                        Container(
                          width: 1.sw,
                          padding: EdgeInsets.all(kSpacingMedium.r),
                          decoration: BoxDecoration(
                            color: MainColors.primaryColor,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(kSpacingMedium.r),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${LanguageStrings.orderWillbeDelivered} ${LanguageStrings.from}",
                                style: TextStyles.mediumLabelTextStyle(context).copyWith(
                                  color: MainColors.whiteColor,
                                  fontSize: 17.sp,
                                ),
                              ),
                              Text(
                                controller.orderDetail!.restaurant.name,
                                style: TextStyles.mediumBodyTextStyle(context).copyWith(
                                  color: MainColors.whiteColor.withOpacity(.75),
                                  fontSize: 13.sp,
                                ),
                              ),

                              SizedBox(height: kSpacingXSmall.h),
                              Divider(
                                height: kSpacingXLarge.h,
                                color: MainColors.secondColor,
                                endIndent: 30,
                                indent: 30,
                                thickness: .5,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: kSpacingLarge.r),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset(
                                      ResourceManager.getAssetResource(statusPending, type: ResourceType.svg),
                                      width: 27.r,
                                      colorFilter: const ColorFilter.mode(
                                        Color(0xFFFFD95F),
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    SizedBox(width: kSpacingXSmall.w),
                                    const Expanded(
                                      child: DashedRect(
                                        color: Color(0xFFFFD95F),
                                        strokeWidth: 2,
                                        gap: 3,
                                      ),
                                    ),
                                    SizedBox(width: kSpacingXSmall.w),
                                    SvgPicture.asset(
                                      ResourceManager.getAssetResource(statusConfirmed, type: ResourceType.svg),
                                      width: 27.r,
                                      colorFilter: ColorFilter.mode(
                                        controller.orderDetail!.orderStatus.id > 1
                                            ? const Color(0xFFFFD95F)
                                            : MainColors.whiteColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    SizedBox(width: kSpacingXSmall.w),
                                    Expanded(
                                      child: DashedRect(
                                        color: controller.orderDetail!.orderStatus.id > 1
                                            ? const Color(0xFFFFD95F)
                                            : MainColors.whiteColor,
                                        strokeWidth: 2,
                                        gap: 3,
                                      ),
                                    ),
                                    SizedBox(width: kSpacingXSmall.w),
                                    SvgPicture.asset(
                                      ResourceManager.getAssetResource(statusCook, type: ResourceType.svg),
                                      width: 27.r,
                                      colorFilter: ColorFilter.mode(
                                        controller.orderDetail!.orderStatus.id > 2
                                            ? const Color(0xFFFFD95F)
                                            : MainColors.whiteColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    SizedBox(width: kSpacingXSmall.w),
                                    Expanded(
                                      child: DashedRect(
                                        color: controller.orderDetail!.orderStatus.id > 2
                                            ? const Color(0xFFFFD95F)
                                            : MainColors.whiteColor,
                                        strokeWidth: 2,
                                        gap: 3,
                                      ),
                                    ),
                                    SizedBox(width: kSpacingXSmall.w),
                                    SvgPicture.asset(
                                      ResourceManager.getAssetResource(statusDelivery, type: ResourceType.svg),
                                      width: 27.r,
                                      colorFilter: ColorFilter.mode(
                                        controller.orderDetail!.orderStatus.id > 3
                                            ? const Color(0xFFFFD95F)
                                            : MainColors.whiteColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    SizedBox(width: kSpacingXSmall.w),
                                    Expanded(
                                      child: DashedRect(
                                        color: controller.orderDetail!.orderStatus.id > 3
                                            ? const Color(0xFFFFD95F)
                                            : MainColors.whiteColor,
                                        strokeWidth: 2,
                                        gap: 3,
                                      ),
                                    ),
                                    SizedBox(width: kSpacingXSmall.w),
                                    SvgPicture.asset(
                                      ResourceManager.getAssetResource(statusDelivred, type: ResourceType.svg),
                                      width: 27.r,
                                      colorFilter: ColorFilter.mode(
                                        controller.orderDetail!.orderStatus.id > 4
                                            ? const Color(0xFFFFD95F)
                                            : MainColors.whiteColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: kSpacingXLarge.h,
                                color: MainColors.secondColor,
                                endIndent: 30,
                                indent: 30,
                                thickness: .5,
                              ),
                              SizedBox(height: kSpacingXSmall.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          LanguageStrings.orderStatus,
                                          style: TextStyles.mediumLabelTextStyle(context).copyWith(
                                            color: MainColors.whiteColor,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                        SizedBox(height: kSpacingXSmall.h),
                                        Text(
                                          controller.orderDetail!.orderStatus.value,
                                          style: TextStyles.mediumBodyTextStyle(context).copyWith(
                                            color: MainColors.whiteColor,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          LanguageStrings.orderDate,
                                          style: TextStyles.mediumLabelTextStyle(context).copyWith(
                                            color: MainColors.whiteColor,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                        SizedBox(height: kSpacingXSmall.h),
                                        Text(
                                          "${controller.orderDetail!.createdAt.split("T")[0]} ${controller.orderDetail!.createdAt.split("T")[1].split(".")[0]}",
                                          style: TextStyles.mediumBodyTextStyle(context).copyWith(
                                            color: MainColors.whiteColor,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: kSpacingLarge.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: MainColors.cardColor(context),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: kSpacingLarge.r,
                                      vertical: kSpacingSmall.r,
                                    ),
                                    child: Text(
                                      "${controller.orderDetail!.amount.totalAmount} ${LanguageStrings.dzd}",
                                      style: TextStyles.mediumLabelTextStyle(context).copyWith(
                                        color: MainColors.primaryColor,
                                        fontSize: 17.sp,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          showModalBottomSheet(
                                            context: Get.context!,
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            builder: (context) => const SafeArea(child: PhoneNumbersComponent()),
                                          );
                                        },
                                        child: Container(
                                          height: 45.h,
                                          width: 45.h,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: const Icon(
                                            Icons.phone,
                                            size: 20,
                                            color: MainColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: MainColors.primaryColor,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
