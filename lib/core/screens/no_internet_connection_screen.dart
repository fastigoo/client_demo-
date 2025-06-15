import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:client/core/resources/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:client/core/resources/images.dart';
import 'package:client/core/resources/language_strings.dart';
import 'package:client/core/services/resource_manager.dart';
import 'package:client/core/styles/main_colors.dart';
import 'package:client/core/styles/text_styles.dart';
import 'package:client/routes/app_pages.dart';

class NoInternetConnectionScreen extends StatefulWidget {
  const NoInternetConnectionScreen({
    super.key,
  });

  @override
  State<NoInternetConnectionScreen> createState() => _NoInternetConnectionScreenState();
}

class _NoInternetConnectionScreenState extends State<NoInternetConnectionScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: MainColors.backgroundColor(context),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(kSpacingMedium.r),
            height: 1.sh,
            width: 1.sw,
            decoration: const BoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ResourceManager.getAssetResource(noWifiImage, type: ResourceType.image),
                  width: 150.w,
                ),
                SizedBox(height: kSpacingXLarge.h),
                Text(
                  LanguageStrings.noInternetConnection,
                  style: TextStyles.mediumLabelTextStyle(context).copyWith(fontSize: 24.sp),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: kSpacingMedium.h),
                Text(
                  LanguageStrings.noInternetConnectionMessage,
                  style: TextStyles.mediumBodyTextStyle(context),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: kSpacingXLarge.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MainColors.primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: kSpacingLarge.w, vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kRadiusSmall.r),
                    ),
                  ),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(FontAwesomeIcons.xmark, color: MainColors.whiteColor, size: 20.sp,),
                      SizedBox(width: kSpacingSmall.w),
                      Text(
                        'Close App',
                        style: TextStyles.mediumLabelTextStyle(context).copyWith(
                          color: MainColors.whiteColor,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
