import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learning/core/styles/main_colors.dart';
import 'package:learning/core/styles/text_styles.dart';

class CartComponent extends StatelessWidget {
  final String imageUrl;

  const CartComponent({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: MainColors.cardColor(context),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
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
                  "Name here",
                  style: TextStyles.mediumBodyTextStyle(context).copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '1000 DA',
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
                      '2000 DA',
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
                          onTap: () {},
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
                      onTap: () {},
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
  }
}
