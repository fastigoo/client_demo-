import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learning/core/resources/images.dart';
import 'package:learning/core/resources/language_strings.dart';
import 'package:learning/core/services/resource_manager.dart';
import 'package:learning/core/styles/main_colors.dart';
import 'package:learning/core/styles/text_styles.dart';
import 'package:learning/routes/app_pages.dart';

class SuccessScreen extends StatelessWidget {
  final String successTitle;
  final String successDesc;
  final String successBtn;

  const SuccessScreen({
    super.key,
    this.successTitle = "",
    this.successDesc = "",
    this.successBtn = "",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
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
              SizedBox(height: kSpacingXLarge.r),
              Image.asset(
                ResourceManager.getAssetResource(successImage, type: ResourceType.image),
                width: 125.w,
              ),
              SizedBox(height: kSpacingXLarge.r),
              Center(
                child: Text(
                  LanguageStrings.success,
                  style: TextStyles.largeLabelTextStyle(context).copyWith(),
                ),
              ),
              SizedBox(height: kSpacingMedium.r),
              Center(
                child: Text(
                  LanguageStrings.successMessage,
                  style: TextStyles.mediumBodyTextStyle(context).copyWith(
                    fontSize: 17.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: kSpacingXLarge.r),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MainColors.primaryColor,
                  minimumSize: Size(1.sw, 55.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kRadiusMedium.r),
                  ),
                ),
                onPressed: () {
                  Get.offAllNamed(Routes.RESTO);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.house,
                      color: MainColors.whiteColor,
                      size: 20.sp,
                    ),
                    SizedBox(width: kSpacingSmall.w),
                    Text(
                      LanguageStrings.backHome,
                      style: TextStyles.mediumBodyTextStyle(context).copyWith(
                        color: MainColors.whiteColor,
                        fontSize: 17.sp,
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
