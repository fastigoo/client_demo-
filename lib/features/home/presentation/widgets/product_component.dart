import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/resources/images.dart';
import 'package:learning/core/services/resource_manager.dart';
import 'package:learning/core/styles/main_colors.dart';
import 'package:learning/core/styles/text_styles.dart';
import 'package:learning/features/cart/domain/entities/cart_entity.dart';
import 'package:learning/features/cart/presentation/states/cart_controller.dart';
import 'package:learning/features/home/domain/entities/menu_item_entity.dart';
import 'package:learning/features/home/presentation/states/product_detail_controller.dart';
import 'package:learning/routes/app_pages.dart';

class ProductComponent extends StatelessWidget {
  final MenuItemEntity item;

  const ProductComponent({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<ProductDetailController>().setItemId(item.menuItemId);
        Get.toNamed(Routes.PRODUCT_DETAIL);
      },
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: MainColors.cardColor(context),
          borderRadius: BorderRadius.circular(kRadiusMedium.r / 2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.1),
              blurRadius: 10,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: TextStyles.mediumBodyTextStyle(context).copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "${item.price} DA",
              style: TextStyles.mediumLabelTextStyle(context).copyWith(
                fontSize: 18.sp,
                color: MainColors.primaryColor,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dashed,
                decorationColor: MainColors.primaryColor,
              ),
            ),
            SizedBox(height: 5.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(kRadiusSmall.r),
              child: Hero(
                tag: item.imageUrl,
                child: Image.network(
                  ResourceManager.getNetworkResource(item.imageUrl),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: kSpacingSmall.r),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _addToCart,
                    child: Container(
                      height: 40.h,
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
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: kSpacingSmall.r),
                GestureDetector(
                  onTap: () {
                    Get.find<CartController>().cartItems.clear();
                    _addToCart();
                    Get.toNamed(Routes.CART);
                  },
                  child: Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: MainColors.primaryColor.withOpacity(.1),
                      borderRadius: BorderRadius.circular(kRadiusSmall.r),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        ResourceManager.getAssetResource(
                          arrowSmallRightIcon,
                          type: ResourceType.svg,
                        ),
                        width: 25.w,
                        colorFilter: const ColorFilter.mode(
                          MainColors.primaryColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _addToCart() {
    CartEntity ce = CartEntity(
      name: item.name,
      itemId: item.menuItemId,
      price: item.price,
      quantity: 1,
      image: item.imageUrl,
    );
    Get.find<CartController>().addToCart(ce);
  }
}
