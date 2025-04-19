import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/services/resource_manager.dart';
import 'package:learning/core/styles/main_colors.dart';
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
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    )..repeat(reverse: true);

    // Initialize the animation
    _animation = Tween<double>(begin: -0.03, end: 0.03).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<CartController>(),
      builder: (controller) {
        return AnimatedBuilder(
          animation: _animation!,
          builder: (context, child) {
            return Transform.rotate(
              angle: _animation!.value,
              child: child,
            );
          },
          child: GestureDetector(
            onTap: () {
              Get.to(() => const CartScreen());
              controller.setRestaurantId(widget.restaurantId);
            },
            child: Container(
              height: 70.h,
              width: double.infinity,
              margin: EdgeInsets.all(kSpacingSmall.r),
              padding: EdgeInsets.all(kSpacingMedium.r),
              decoration: BoxDecoration(
                color: MainColors.primaryColor,
                borderRadius: BorderRadius.circular(kRadiusMedium.r),
                border: Border.all(
                  color: MainColors.warningColor(context)!.withOpacity(.5),
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Stack(
                                  alignment: Alignment.centerLeft,
                                  children: [
                                    for (int i = 0; i < controller.cartItems.length; i++) ...{
                                      Positioned(
                                        left: i * 20.w,
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
                                            child: Image.network(
                                              ResourceManager.getNetworkResource(
                                                controller.cartItems[i].image,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    },
                                  ],
                                ),
                              ),
                              FaIcon(
                                FontAwesomeIcons.opencart,
                                color: MainColors.whiteColor,
                                size: 20.w,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
