import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:learning/core/components/others/dashed_rect.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/resources/images.dart';
import 'package:learning/core/services/resource_manager.dart';
import 'package:learning/core/styles/main_colors.dart';
import 'package:learning/core/styles/text_styles.dart';
import 'package:learning/features/cart/presentation/states/place_order_controller.dart';
import 'package:learning/routes/app_pages.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PlaceOrderScreen extends GetView<PlaceOrderController> {
  const PlaceOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.cardColor(context),
      body: Obx(
        () => SafeArea(
          child: controller.isLoading.isFalse
              ? Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(kSpacingMedium.r),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: "Order ID: ",
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
                              Get.offAndToNamed(Routes.HOME);
                            },
                            child: Container(
                              height: 40.w,
                              padding: EdgeInsets.symmetric(
                                horizontal: kSpacingMedium.r,
                                vertical: kSpacingXSmall.r,
                              ),
                              decoration: BoxDecoration(
                                color: MainColors.primaryColor,
                                borderRadius: BorderRadius.circular(kRadiusSmall.r),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "Back",
                                    style: TextStyles.mediumBodyTextStyle(context).copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: kSpacingXSmall.w),
                                  FaIcon(
                                    FontAwesomeIcons.xmark,
                                    color: Colors.white,
                                    size: 20.r,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        ResourceManager.getAssetResource(
                          pendingImage,
                          type: ResourceType.image,
                        ),
                        width: 120.h,
                        height: 120.w,
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
                            "Order will be delivered from",
                            style: TextStyles.mediumLabelTextStyle(context).copyWith(
                              color: MainColors.whiteColor,
                              fontSize: 17.sp,
                            ),
                          ),
                          Text(
                            controller.orderDetail!.restaurant.name,
                            style: TextStyles.mediumBodyTextStyle(context).copyWith(
                              color: MainColors.disableColor(context),
                              fontSize: 13.sp,
                            ),
                          ),
                          SizedBox(height: kSpacingSmall.h),
                          Text(
                            "Order will be delivered to",
                            style: TextStyles.mediumLabelTextStyle(context).copyWith(
                              color: MainColors.whiteColor,
                              fontSize: 17.sp,
                            ),
                          ),
                          Text(
                            "${controller.orderDetail!.customerLocation.country} - ${controller.orderDetail!.customerLocation.road} - ${controller.orderDetail!.customerLocation.city}",
                            style: TextStyles.mediumBodyTextStyle(context).copyWith(
                              color: MainColors.disableColor(context),
                              fontSize: 13.sp,
                            ),
                          ),
                          SizedBox(height: kSpacingXSmall.h),
                          Divider(
                            height: kSpacingXLarge.h,
                            color: MainColors.secondColor.withOpacity(.2),
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
                                    MainColors.secondColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SizedBox(width: kSpacingXSmall.w),
                                const Expanded(
                                  child: DashedRect(
                                    color: MainColors.secondColor,
                                    strokeWidth: 2,
                                    gap: 3,
                                  ),
                                ),
                                SizedBox(width: kSpacingXSmall.w),
                                SvgPicture.asset(
                                  ResourceManager.getAssetResource(statusConfirmed, type: ResourceType.svg),
                                  width: 27.r,
                                  colorFilter: ColorFilter.mode(
                                    controller.status > 1 ? MainColors.secondColor : MainColors.whiteColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SizedBox(width: kSpacingXSmall.w),
                                Expanded(
                                  child: DashedRect(
                                    color: controller.status > 1 ? MainColors.secondColor : MainColors.whiteColor,
                                    strokeWidth: 2,
                                    gap: 3,
                                  ),
                                ),
                                SizedBox(width: kSpacingXSmall.w),
                                SvgPicture.asset(
                                  ResourceManager.getAssetResource(statusCook, type: ResourceType.svg),
                                  width: 27.r,
                                  colorFilter: ColorFilter.mode(
                                    controller.status > 2 ? MainColors.secondColor : MainColors.whiteColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SizedBox(width: kSpacingXSmall.w),
                                Expanded(
                                  child: DashedRect(
                                    color: controller.status > 2 ? MainColors.secondColor : MainColors.whiteColor,
                                    strokeWidth: 2,
                                    gap: 3,
                                  ),
                                ),
                                SizedBox(width: kSpacingXSmall.w),
                                SvgPicture.asset(
                                  ResourceManager.getAssetResource(statusDelivery, type: ResourceType.svg),
                                  width: 27.r,
                                  colorFilter: ColorFilter.mode(
                                    controller.status > 3 ? MainColors.secondColor : MainColors.whiteColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SizedBox(width: kSpacingXSmall.w),
                                Expanded(
                                  child: DashedRect(
                                    color: controller.status > 3 ? MainColors.secondColor : MainColors.whiteColor,
                                    strokeWidth: 2,
                                    gap: 3,
                                  ),
                                ),
                                SizedBox(width: kSpacingXSmall.w),
                                SvgPicture.asset(
                                  ResourceManager.getAssetResource(statusDelivred, type: ResourceType.svg),
                                  width: 27.r,
                                  colorFilter: ColorFilter.mode(
                                    controller.status > 4 ? MainColors.secondColor : MainColors.whiteColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: kSpacingXLarge.h,
                            color: MainColors.secondColor.withOpacity(.2),
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
                                      "Order Status",
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
                                      "Order Date",
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
                                  color: MainColors.secondColor,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: kSpacingLarge.r,
                                  vertical: kSpacingSmall.r,
                                ),
                                child: Text(
                                  "${controller.orderDetail!.amount.totalAmount} ${controller.orderDetail!.amount.currency}",
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
                                      Uri phoneno = Uri.parse('tel:0777656565');
                                      if(await canLaunchUrl(phoneno)){
                                        await launchUrl(phoneno);
                                      }else {
                                        //cannot launch phone
                                      }
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
      ),
    );
  }
}
