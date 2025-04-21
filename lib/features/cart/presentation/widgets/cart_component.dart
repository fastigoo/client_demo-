import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/resources/language_strings.dart';
import 'package:learning/core/services/resource_manager.dart';
import 'package:learning/core/styles/main_colors.dart';
import 'package:learning/core/styles/text_styles.dart';
import 'package:learning/features/cart/domain/entities/cart_entity.dart';
import 'package:learning/features/cart/presentation/states/cart_controller.dart';

class CartComponent extends StatelessWidget {
  final CartEntity item;

  const CartComponent({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<CartController>(),
      builder: (controller) {
        return Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: MainColors.cardColor(context),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 100.w,
                height: 100.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(kSpacingSmall.r),
                  child: Image.network(
                    ResourceManager.getNetworkResource(item.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyles.mediumBodyTextStyle(context).copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${item.price} ${LanguageStrings.dzd}',
                          style: TextStyles.mediumLabelTextStyle(context).copyWith(
                            color: MainColors.primaryColor,
                            fontSize: 15.sp,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.dashed,
                            decorationColor: MainColors.primaryColor,
                            decorationThickness: 2,
                          ),
                        ),
                        Text(
                          '${item.price * item.quantity} ${LanguageStrings.dzd}',
                          style: TextStyles.mediumBodyTextStyle(context).copyWith(
                            color: MainColors.textColor(context),
                            fontWeight: FontWeight.w400,
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.removeQuantity(itemId: item.itemId);
                              },
                              child: Container(
                                width: 30.r,
                                height: 30.r,
                                decoration: BoxDecoration(
                                  color: MainColors.backgroundColor(context),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.r),
                                    bottomLeft: Radius.circular(5.r),
                                  ),
                                  border: Border.all(
                                    color: MainColors.textColor(context)!.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: FaIcon(
                                    FontAwesomeIcons.minus,
                                    color: MainColors.textColor(context),
                                    size: 15.r,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              constraints: BoxConstraints(
                                minWidth: 30.r,
                              ),
                              decoration: BoxDecoration(
                                color: MainColors.transparentColor,
                                border: Border(
                                  top: BorderSide(
                                    color: MainColors.textColor(context)!.withOpacity(0.2),
                                    width: 1,
                                  ),
                                  bottom: BorderSide(
                                    color: MainColors.textColor(context)!.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                              ),
                              height: 30.r,
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Center(
                                child: Text(
                                  item.quantity.toString(),
                                  style: TextStyles.mediumBodyTextStyle(context).copyWith(
                                    color: MainColors.textColor(context),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.addQuantity(itemId: item.itemId);
                              },
                              child: Container(
                                width: 30.r,
                                height: 30.r,
                                decoration: BoxDecoration(
                                  color: MainColors.backgroundColor(context),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5.r),
                                    bottomRight: Radius.circular(5.r),
                                  ),
                                  border: Border.all(
                                    color: MainColors.textColor(context)!.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: FaIcon(
                                    FontAwesomeIcons.plus,
                                    color: MainColors.textColor(context),
                                    size: 15.r,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.removeFromCart(item);
                          },
                          child: Container(
                            width: 30.r,
                            height: 30.r,
                            decoration: BoxDecoration(
                              color: MainColors.primaryColor,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.xmark,
                                color: MainColors.whiteColor,
                                size: 15.r,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
