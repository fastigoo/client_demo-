import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:client/core/resources/constants.dart';
import 'package:client/core/styles/main_colors.dart';

class TextStyles {
  static TextStyle smallBodyTextStyle(BuildContext context) => TextStyle(
        fontFamily: kFontFamily,
        fontSize: 13.sp,
        color: MainColors.textColor(context),
      );

  static TextStyle mediumBodyTextStyle(BuildContext context) => TextStyle(
        fontFamily: kFontFamily,
        fontSize: 15.sp,
        color: MainColors.textColor(context),
      );

  //create another styles here
  static TextStyle largeBodyTextStyle(BuildContext context) => TextStyle(
        fontFamily: kFontFamily,
        fontSize: 17.sp,
        color: MainColors.textColor(context),
      );

  static TextStyle buttonTextStyle(BuildContext context) => TextStyle(
        fontFamily: kFontFamily,
        fontSize: 15.sp,
        color: MainColors.textColor(context),
      );

  static TextStyle smallLabelTextStyle(BuildContext context) => TextStyle(
        fontFamily: kFontFamily,
        height: 1.72,
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
        color: MainColors.textColor(context),
      );

  static TextStyle mediumLabelTextStyle(BuildContext context) => TextStyle(
        fontFamily: kFontFamily,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: MainColors.textColor(context),
      );

  static TextStyle largeLabelTextStyle(BuildContext context) => TextStyle(
        fontFamily: kFontFamily,
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        color: MainColors.textColor(context),
      );
}
