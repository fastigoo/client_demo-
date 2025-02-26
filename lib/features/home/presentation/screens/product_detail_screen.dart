import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/resources/images.dart';
import 'package:learning/core/services/resource_manager.dart';
import 'package:learning/core/styles/main_colors.dart';
import 'package:learning/core/styles/text_styles.dart';
import 'package:learning/features/cart/domain/entities/cart_entity.dart';
import 'package:learning/features/cart/presentation/states/cart_controller.dart';
import 'package:learning/features/home/presentation/states/product_detail_controller.dart';

class ProductDetailScreen extends GetView<ProductDetailController> {
  const ProductDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.backgroundColor(context),
      body: Obx(
        () => controller.isLoading.isFalse
            ? SingleChildScrollView(
                child: SizedBox(
                  height: 1.sh,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: 9 / 9,
                            child: Hero(
                              tag: controller.itemDetail!.imageUrl,
                              child: Image.network(
                                ResourceManager.getNetworkResource(controller.itemDetail!.imageUrl),
                                width: double.infinity,
                                height: 250.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10.h,
                            left: 20.w,
                            child: SafeArea(
                              child: Container(
                                width: 45.w,
                                height: 45.w,
                                decoration: BoxDecoration(
                                  color: MainColors.primaryColor,
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color: MainColors.whiteColor,
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: FaIcon(
                                      FontAwesomeIcons.chevronLeft,
                                      color: MainColors.whiteColor,
                                      size: 20.r,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.itemDetail!.name,
                              style: TextStyles.largeLabelTextStyle(context).copyWith(
                                fontSize: 25.sp,
                              ),
                            ).paddingSymmetric(horizontal: kSpacingMedium.r),
                            SizedBox(height: kSpacingXSmall.r),
                            Text(
                              controller.itemDetail!.description,
                              style: TextStyles.mediumBodyTextStyle(context).copyWith(
                                fontSize: 14.sp,
                              ),
                            ).paddingSymmetric(horizontal: kSpacingMedium.r),
                            SizedBox(height: kSpacingSmall.r),
                            Text(
                              '${controller.itemDetail!.price} DA',
                              style: TextStyles.largeBodyTextStyle(context).copyWith(
                                color: MainColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.sp,
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.dashed,
                              ),
                            ).paddingSymmetric(horizontal: kSpacingMedium.r),
                            if (controller.itemDetail!.variants != null) ...{
                              SizedBox(height: kSpacingMedium.h),
                              SizedBox(
                                height: 60.h,
                                child: ListView.separated(
                                  itemCount: controller.itemDetail!.variants!.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.symmetric(horizontal: kSpacingMedium.r),
                                  separatorBuilder: (context, index) {
                                    return SizedBox(width: 10.w);
                                  },
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(horizontal: kSpacingMedium.r),
                                      constraints: BoxConstraints(
                                        minWidth: 65.w,
                                      ),
                                      decoration: BoxDecoration(
                                        color: index != 0 ? MainColors.cardColor(context) : MainColors.primaryColor,
                                        borderRadius: BorderRadius.circular(kRadiusSmall.r),
                                      ),
                                      child: Center(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.utensils,
                                              color: index != 0 ? MainColors.textColor(context) : MainColors.whiteColor,
                                              size: 25.r,
                                            ),
                                            // Icon(Icons.bowl, color: index != 0 ? MainColors.textColor(context) : MainColors.whiteColor, size: 15.r
                                            SizedBox(width: kSpacingSmall.w),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  controller.itemDetail!.variants![index].name,
                                                  style: TextStyles.mediumBodyTextStyle(context).copyWith(
                                                    color: index != 0 ? MainColors.textColor(context) : MainColors.whiteColor,
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                                SizedBox(height: 5.h),
                                                Text(
                                                  "${controller.itemDetail!.variants![index].price} DA",
                                                  style: TextStyles.mediumLabelTextStyle(context).copyWith(
                                                    color: index != 0 ? MainColors.textColor(context) : MainColors.whiteColor,
                                                    fontSize: 15.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            },
                            SizedBox(height: kSpacingXLarge.h * 2),
                            Expanded(
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          CartEntity ce = CartEntity(
                                            name: controller.itemDetail!.name,
                                            itemId: controller.itemDetail!.menuItemId,
                                            price: controller.itemDetail!.price,
                                            quantity: 1,
                                            image: controller.itemDetail!.imageUrl,
                                          );
                                          Get.find<CartController>().addToCart(ce);
                                        },
                                        child: Container(
                                          height: 50.h,
                                          decoration: BoxDecoration(
                                            color: MainColors.primaryColor,
                                            borderRadius: BorderRadius.circular(kRadiusSmall.r),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                ResourceManager.getAssetResource(
                                                  addCartIcon,
                                                  type: ResourceType.svg,
                                                ),
                                                width: 15.w,
                                                colorFilter: const ColorFilter.mode(
                                                  MainColors.whiteColor,
                                                  BlendMode.srcIn,
                                                ),
                                              ),
                                              SizedBox(width: 5.w),
                                              Text(
                                                "Add to cart",
                                                style: TextStyles.mediumBodyTextStyle(context).copyWith(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Container(
                                      width: 50.w,
                                      height: 50.h,
                                      decoration: BoxDecoration(
                                        color: MainColors.primaryColor.withOpacity(.1),
                                        borderRadius: BorderRadius.circular(kRadiusSmall.r),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          ResourceManager.getAssetResource(
                                            heartIcon,
                                            type: ResourceType.svg,
                                          ),
                                          width: 20.w,
                                          colorFilter: const ColorFilter.mode(
                                            MainColors.primaryColor,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ).paddingSymmetric(horizontal: kSpacingMedium.r),
                              ),
                            ),
                            SizedBox(height: kSpacingMedium.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
