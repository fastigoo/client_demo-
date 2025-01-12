import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/resources/language_strings.dart';
import 'package:learning/core/styles/main_colors.dart';
import 'package:learning/core/styles/text_styles.dart';
import 'package:learning/features/cart/presentation/states/cart_controller.dart';
import 'package:learning/features/cart/presentation/widgets/cart_component.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> _list = [
      "https://www.cookwithnabeela.com/wp-content/uploads/2024/02/FrenchFries.webp",
      "https://w0.peakpx.com/wallpaper/47/200/HD-wallpaper-food-sandwich.jpg",
      "https://static.vecteezy.com/system/resources/thumbnails/028/139/670/small_2x/side-view-shawarma-with-fried-potatoes-in-board-cookware-photo.jpg",
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
          style: TextStyles.mediumLabelTextStyle(context).copyWith(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        toolbarHeight: 60.h,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: _list.length,
              padding: EdgeInsets.all(16.w),
              itemBuilder: (context, index) {
                return CartComponent(imageUrl: _list[index]);
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10.h);
              },
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            height: 155.h,
            padding: EdgeInsets.all(kSpacingSmall.r),
            decoration: BoxDecoration(
              color: MainColors.cardColor(context),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Cost",
                      style: TextStyles.mediumBodyTextStyle(context).copyWith(
                        fontSize: 17.sp,
                      ),
                    ),
                    Text(
                      '900 DA',
                      style: TextStyles.mediumLabelTextStyle(context).copyWith(
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.dotted,
                        decorationThickness: 3,
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
                        fontSize: 17.sp,
                      ),
                    ),
                    Text(
                      '100 DA',
                      style: TextStyles.mediumLabelTextStyle(context).copyWith(
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.dotted,
                        decorationThickness: 3,
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
                        fontSize: 17.sp,
                      ),
                    ),
                    Text(
                      '1000 DA',
                      style: TextStyles.mediumLabelTextStyle(context).copyWith(
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.dotted,
                        decorationThickness: 3,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MainColors.primaryColor,
                    minimumSize: Size(double.infinity, 45.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kRadiusSmall.r),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    LanguageStrings.confirmOrder,
                    style: TextStyles.mediumLabelTextStyle(context).copyWith(
                      color: Colors.white,
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
