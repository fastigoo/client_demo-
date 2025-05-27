import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:learning/core/components/others/network_image_component.dart';
import 'package:learning/core/helper/translation_util.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/resources/images.dart';
import 'package:learning/core/resources/language_strings.dart';
import 'package:learning/core/resources/states_ids.dart';
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
                  height: 1.sh - MediaQuery.of(context).padding.top,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          GetBuilder(
                              init: controller,
                              id: StatesIds.productDetail,
                              builder: (ProductDetailController controller) {
                                return AspectRatio(
                                  aspectRatio: 9 / 9,
                                  child: Hero(
                                    tag: controller.productDetailModel!.imageUrl,
                                    // child: Image.network(
                                    //   ResourceManager.getNetworkResource(controller.productDetailModel!.imageUrl),
                                    //   width: double.infinity,
                                    //   height: 250.h,
                                    //   fit: BoxFit.cover,
                                    // ),
                                    child: CacheNetworkImageComponent(
                                      imageUrl: ResourceManager.getNetworkResource(controller.productDetailModel!.imageUrl),
                                    ),
                                  ),
                                );
                              }),
                          Positioned(
                            top: 10.h,
                            right: TranslationUtil.isRtl() ? 20.w : null,
                            left: TranslationUtil.isRtl() ? null : 20.w,
                            child: SafeArea(
                              child: Container(
                                width: 50.w,
                                height: 50.w,
                                decoration: BoxDecoration(
                                  color: MainColors.cardColor(context),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: FaIcon(
                                      TranslationUtil.isRtl() ? FontAwesomeIcons.chevronRight : FontAwesomeIcons.chevronLeft,
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
                      GetBuilder(
                        init: controller,
                        id: StatesIds.productDetail,
                        builder: (controller) {
                          return Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.productDetailModel!.name,
                                  style: TextStyles.largeLabelTextStyle(context).copyWith(
                                    fontSize: 25.sp,
                                  ),
                                ).paddingSymmetric(horizontal: kSpacingMedium.r),
                                SizedBox(height: kSpacingXSmall.r),
                                Text(
                                  controller.productDetailModel!.description,
                                  style: TextStyles.mediumBodyTextStyle(context).copyWith(
                                    fontSize: 14.sp,
                                  ),
                                ).paddingSymmetric(horizontal: kSpacingMedium.r),
                                SizedBox(height: kSpacingSmall.r),
                                Text(
                                  '${controller.productDetailModel!.price} ${LanguageStrings.dzd}',
                                  style: TextStyles.largeBodyTextStyle(context).copyWith(
                                    color: MainColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.sp,
                                  ),
                                ).paddingSymmetric(horizontal: kSpacingMedium.r),
                                if (controller.initialProductDetailModel!.variants != null) ...{
                                  SizedBox(height: kSpacingMedium.h),
                                  SizedBox(
                                    height: 60.h,
                                    child: ListView.separated(
                                      itemCount: controller.initialProductDetailModel!.variants!.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      padding: EdgeInsets.symmetric(horizontal: kSpacingMedium.r),
                                      separatorBuilder: (context, index) {
                                        return SizedBox(width: 10.w);
                                      },
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            if (controller.initialProductDetailModel!.variants![index].menuItemVariantId ==
                                                controller.selectedVariant) {
                                              controller.setSelectedVariant(index: index, value: 0);
                                            } else {
                                              controller.setSelectedVariant(
                                                index: index,
                                                value: controller.initialProductDetailModel!.variants![index].menuItemVariantId,
                                              );
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: kSpacingMedium.r),
                                            constraints: BoxConstraints(
                                              minWidth: 65.w,
                                            ),
                                            decoration: BoxDecoration(
                                              color: !controller.isSameVariant(
                                                      controller.initialProductDetailModel!.variants![index].menuItemVariantId)
                                                  ? MainColors.cardColor(context)
                                                  : MainColors.primaryColor,
                                              borderRadius: BorderRadius.circular(kRadiusSmall.r),
                                            ),
                                            child: Center(
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  FaIcon(
                                                    FontAwesomeIcons.cubesStacked,
                                                    color: !controller.isSameVariant(controller
                                                            .initialProductDetailModel!.variants![index].menuItemVariantId)
                                                        ? MainColors.textColor(context)
                                                        : MainColors.whiteColor,
                                                    size: 25.r,
                                                  ),
                                                  // Icon(Icons.bowl, color: index != 0 ? MainColors.textColor(context) : MainColors.whiteColor, size: 15.r
                                                  SizedBox(width: kSpacingSmall.w),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        controller.initialProductDetailModel!.variants![index].name,
                                                        style: TextStyles.mediumBodyTextStyle(context).copyWith(
                                                          color: !controller.isSameVariant(controller
                                                                  .initialProductDetailModel!.variants![index].menuItemVariantId)
                                                              ? MainColors.textColor(context)
                                                              : MainColors.whiteColor,
                                                          fontSize: 12.sp,
                                                        ),
                                                      ),
                                                      SizedBox(height: 5.h),
                                                      Text(
                                                        "${controller.initialProductDetailModel!.variants![index].price} ${LanguageStrings.dzd}",
                                                        style: TextStyles.mediumLabelTextStyle(context).copyWith(
                                                          color: !controller.isSameVariant(controller
                                                                  .initialProductDetailModel!.variants![index].menuItemVariantId)
                                                              ? MainColors.textColor(context)
                                                              : MainColors.whiteColor,
                                                          fontSize: 15.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
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
                                                name: controller.productDetailModel!.name,
                                                itemId: controller.productDetailModel!.menuItemId,
                                                price: controller.productDetailModel!.price,
                                                quantity: 1,
                                                image: controller.productDetailModel!.imageUrl,
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
                                                    LanguageStrings.addToCart,
                                                    style: TextStyles.mediumBodyTextStyle(context).copyWith(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ).paddingSymmetric(horizontal: kSpacingMedium.r),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2.r,
                  color: MainColors.primaryColor,
                ),
              ),
      ),
    );
  }
}
