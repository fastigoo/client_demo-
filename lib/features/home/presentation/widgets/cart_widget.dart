import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning/core/components/others/network_image_component.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/resources/language_strings.dart';
import 'package:learning/core/services/resource_manager.dart';
import 'package:learning/core/styles/main_colors.dart';
import 'package:learning/core/styles/text_styles.dart';
import 'package:learning/features/cart/presentation/screens/cart_screen.dart';
import 'package:get/get.dart';
import 'package:learning/features/cart/presentation/states/cart_controller.dart';

class CartWidget extends StatefulWidget {
  final int restaurantId;

  const CartWidget({
    super.key,
    required this.restaurantId,
  });

  @override
  State<CartWidget> createState() => _CartWidgetState();
}
class _CartWidgetState extends State<CartWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: 0, end: 5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeInOut),
      ),
    );

    _rotationAnimation = Tween<double>(begin: -0.03, end: 0.03).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _colorAnimation = ColorTween(
      begin: MainColors.warningColor(context)!.withOpacity(0.5),
      end: MainColors.warningColor(context)!.withOpacity(0.8),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (controller) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform(
              transform: Matrix4.identity()
                ..translate(0.0, -_bounceAnimation.value)
                ..scale(_scaleAnimation.value)
                ..rotateZ(_rotationAnimation.value),
              alignment: Alignment.center,
              child: child,
            );
          },
          child: GestureDetector(
            onTap: () {
              Get.to(() => const CartScreen());
              controller.setRestaurantId(widget.restaurantId);
            },
            child: AnimatedBuilder(
              animation: _colorAnimation,
              builder: (context, child) {
                return Container(
                  height: 75.h,
                  width: double.infinity,
                  margin: EdgeInsets.all(kSpacingSmall.r),
                  padding: EdgeInsets.all(kSpacingMedium.r),
                  decoration: BoxDecoration(
                    color: MainColors.primaryColor,
                    borderRadius: BorderRadius.circular(kRadiusMedium.r),
                    border: Border.all(
                      color: _colorAnimation.value!,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LanguageStrings.cart,
                        style: TextStyles.mediumLabelTextStyle(context).copyWith(
                          fontSize: 16.sp,
                          color: MainColors.whiteColor,
                          decoration: TextDecoration.underline,
                          decorationColor: MainColors.whiteColor,
                          decorationStyle: TextDecorationStyle.dashed,
                          decorationThickness: 2,
                        ),
                      ),
                      SizedBox(
                        width: (35 + (min(controller.cartItems.length - 1, 4) * 15)).w,
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            for (int i = 0; i < min(controller.cartItems.length, 4); i++) ...{
                              Positioned(
                                left: i * 15.w,
                                child: Container(
                                  height: 35.h,
                                  width: 35.w,
                                  decoration: const BoxDecoration(
                                    color: MainColors.whiteColor,
                                    shape: BoxShape.circle,
                                    border: Border.fromBorderSide(
                                      BorderSide(
                                        color: MainColors.whiteColor,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(kRadiusMedium.r),
                                    child: CacheNetworkImageComponent(
                                      imageUrl: ResourceManager.getNetworkResource(
                                        controller.cartItems[i].image,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            },
                            if (max(controller.cartItems.length, 4) > 4)
                              Positioned(
                                right: 0,
                                child: Container(
                                  height: 35.h,
                                  width: 35.w,
                                  decoration: const BoxDecoration(
                                    color: MainColors.whiteColor,
                                    shape: BoxShape.circle,
                                    border: Border.fromBorderSide(
                                      BorderSide(
                                        color: MainColors.whiteColor,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: MainColors.whiteColor,
                                    child: Text(
                                      "+${controller.cartItems.length - 4}",
                                      style: TextStyles.mediumLabelTextStyle(context).copyWith(
                                        fontSize: 12.sp,
                                        color: MainColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}