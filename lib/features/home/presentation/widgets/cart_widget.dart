import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/services/resource_manager.dart';
import 'package:learning/core/styles/main_colors.dart';
import 'package:learning/core/styles/text_styles.dart';
import 'package:learning/features/cart/presentation/screens/cart_screen.dart';
import 'package:get/get.dart';
import 'package:learning/features/cart/presentation/states/cart_controller.dart';


class CartWidget extends StatelessWidget {
  final int restaurantId;
  const CartWidget({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<CartController>(),
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            Get.to(() => const CartScreen());
            controller.setRestaurantId(restaurantId);
          },
          child: Container(
            height: 100.h,
            width: double.infinity,
            margin: EdgeInsets.all(kSpacingSmall.r),
            padding: EdgeInsets.all(kSpacingMedium.r),
            decoration: BoxDecoration(
              color: MainColors.primaryColor,
              borderRadius: BorderRadius.circular(kRadiusMedium.r),
              border: Border.all(
                color: Colors.black.withOpacity(.2),
                width: 2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Cart",
                        style: TextStyles.mediumLabelTextStyle(context).copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: " (${controller.cartItems.length} items)",
                            style: GoogleFonts.fredoka(
                              fontSize: 14.sp,
                              color: Colors.white.withOpacity(.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${controller.getTotalPrice()} DA",
                      style: GoogleFonts.fredoka(
                        fontSize: 20.sp,
                        color: MainColors.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
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
                              FontAwesomeIcons.arrowRight,
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
        );
      }
    );
  }
}
