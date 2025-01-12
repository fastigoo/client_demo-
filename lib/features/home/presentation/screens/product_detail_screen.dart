import 'package:flutter/cupertino.dart';
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

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final String image = args['image'];

    return Scaffold(
      backgroundColor: MainColors.backgroundColor(context),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 9 / 9,
                    child: Hero(
                      tag: image,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          image,
                          width: double.infinity,
                          height: 250.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 35.h,
                    left: 20.w,
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
                ],
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "item title here",
                      style: TextStyles.largeLabelTextStyle(context).copyWith(
                        fontSize: 28.sp,
                      ),
                    ).paddingSymmetric(horizontal: kSpacingMedium.r),
                    SizedBox(height: 5.h),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in.",
                      style: TextStyles.mediumBodyTextStyle(context),
                    ).paddingSymmetric(horizontal: kSpacingMedium.r),
                    SizedBox(height: 10.h),
                    Text(
                      '${500} DA',
                      style: TextStyles.largeBodyTextStyle(context).copyWith(
                        color: MainColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.sp,
                      ),
                    ).paddingSymmetric(horizontal: kSpacingMedium.r),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 50.h,
                      child: ListView.separated(
                        itemCount: 4,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: kSpacingMedium.r),
                        separatorBuilder: (context, index) {
                          return SizedBox(width: 10.w);
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: kSpacingMedium.r),
                            decoration: BoxDecoration(
                              color: index != 0 ? MainColors.cardColor(context) : MainColors.primaryColor,
                              borderRadius: BorderRadius.circular(kRadiusSmall.r),
                            ),
                            child: Center(
                              child: Text(
                                "XL",
                                style: TextStyles.mediumBodyTextStyle(context).copyWith(
                                  color: index != 0 ? MainColors.textColor(context) : MainColors.whiteColor,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.only(bottom: kSpacingMedium.r),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: 35.r,
                                    height: 35.r,
                                    decoration: BoxDecoration(
                                      color: MainColors.cardColor(context),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5.r),
                                        bottomLeft: Radius.circular(5.r),
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
                                    minWidth: 35.r,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: MainColors.transparentColor,
                                  ),
                                  height: 35.r,
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Center(
                                    child: Text(
                                      3.toString(),
                                      style: TextStyles.mediumBodyTextStyle(context).copyWith(
                                        color: MainColors.textColor(context),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: 35.r,
                                    height: 35.r,
                                    decoration: BoxDecoration(
                                      color: MainColors.cardColor(context),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(5.r),
                                        bottomRight: Radius.circular(5.r),
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
                            SizedBox(height: kSpacingMedium.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
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
                          ],
                        ),
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
  }
}
