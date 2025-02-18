import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/resources/language_strings.dart';
import 'package:learning/core/styles/main_colors.dart';
import 'package:learning/core/styles/text_styles.dart';
import 'package:learning/features/cart/presentation/states/cart_controller.dart';
import 'package:learning/features/cart/presentation/widgets/cart_component.dart';
import 'package:learning/features/cart/presentation/widgets/confirm_order_component.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> _list = [
      "https://w0.peakpx.com/wallpaper/47/200/HD-wallpaper-food-sandwich.jpg",
      "https://static.vecteezy.com/system/resources/thumbnails/028/139/670/small_2x/side-view-shawarma-with-fried-potatoes-in-board-cookware-photo.jpg",
    ];

    return Scaffold(
      resizeToAvoidBottomInset: true, // Prevents the Scaffold from resizing
      appBar: AppBar(
        title: Text(
          "Cart",
          style: TextStyles.mediumLabelTextStyle(context).copyWith(
            color: Colors.white,
          ),
        ),
        titleSpacing: 5.w,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        toolbarHeight: 55.h,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: _list.length,
              padding: EdgeInsets.all(kSpacingSmall.r),
              itemBuilder: (context, index) {
                return CartComponent(imageUrl: _list[index]);
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: kSpacingSmall.h);
              },
            ),
          ),
          SizedBox(height: kSpacingMedium.h),
          Container(
            padding: EdgeInsets.all(kSpacingSmall.r),
            decoration: BoxDecoration(
              color: MainColors.cardColor(context),
              border: Border(
                top: BorderSide(
                  color: MainColors.primaryColor.withOpacity(.2),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Cost",
                      style: TextStyles.mediumBodyTextStyle(context).copyWith(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '900 DA',
                      style: TextStyles.mediumLabelTextStyle(context).copyWith(
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.dashed,
                        decorationThickness: 2,
                        fontSize: 18.sp,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Delivery fee",
                      style: TextStyles.mediumBodyTextStyle(context).copyWith(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '100 DA',
                      style: TextStyles.mediumLabelTextStyle(context).copyWith(
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.dashed,
                        decorationThickness: 2,
                        fontSize: 18.sp,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyles.mediumBodyTextStyle(context).copyWith(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '1000 DA',
                      style: TextStyles.mediumLabelTextStyle(context).copyWith(
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.dashed,
                        decorationThickness: 2,
                        fontSize: 18.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: kSpacingSmall.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MainColors.primaryColor,
                    minimumSize: Size(double.infinity, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kRadiusMedium.r),
                    ),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => ConfirmOrderComponent(
                        phoneController: TextEditingController(text: "0"),
                      ),
                    );
                  },
                  child: Text(
                    LanguageStrings.confirmOrder,
                    style: TextStyles.mediumLabelTextStyle(context).copyWith(
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
