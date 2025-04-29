import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

class SuccessScreen extends StatefulWidget {
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
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: Colors.transparent,
                height: 50.h,
                width: 1.sw,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.offAllNamed(Routes.RESTO);
                      },
                      child: Container(
                        width: 50.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: MainColors.textColor(context)!,
                            width: 1.w,
                          ),
                        ),
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.xmark,
                            color: MainColors.textColor(context)!,
                            size: 25.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                ResourceManager.getAssetResource(successImage, type: ResourceType.image),
                width: 150.w,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MainColors.successColor(context),
                  minimumSize: Size(1.sw, 55.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kRadiusSmall.r),
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
