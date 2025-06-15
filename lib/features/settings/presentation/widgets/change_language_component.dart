import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:client/core/components/buttons/checked_element_component.dart';
import 'package:client/core/components/buttons/icon_button_component.dart';
import 'package:client/core/helper/translation_util.dart';
import 'package:client/core/resources/constants.dart';
import 'package:client/core/resources/images.dart';
import 'package:client/core/resources/language_strings.dart';
import 'package:client/core/services/resource_manager.dart';
import 'package:client/core/styles/main_colors.dart';
import 'package:client/core/styles/text_styles.dart';

class ChangeAppLangWindowComponent extends StatefulWidget {
  const ChangeAppLangWindowComponent({
    super.key,
  });

  @override
  State<ChangeAppLangWindowComponent> createState() => _ChangeAppLangWindowComponentState();
}

class _ChangeAppLangWindowComponentState extends State<ChangeAppLangWindowComponent> {
  String? lang;

  @override
  void initState() {
    lang = Get.locale?.languageCode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: MainColors.backgroundColor(context),
            borderRadius: BorderRadiusDirectional.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  LanguageStrings.changeLanguage,
                  style: TextStyles.mediumLabelTextStyle(context),
                ),
              ),
              SizedBox(height: 20.h),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: CheckedElementComponent(
                                    title: 'العربية',
                                    isChecked: lang == 'ar',
                                    isExpanded: true,
                                    onTap: () {
                                      setState(() {
                                        lang = 'ar';
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CheckedElementComponent(
                                    title: 'Français',
                                    isChecked: lang == 'fr',
                                    isExpanded: true,
                                    onTap: () {
                                      setState(() {
                                        lang = 'fr';
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CheckedElementComponent(
                                    title: 'English',
                                    isChecked: lang == 'en',
                                    isExpanded: true,
                                    onTap: () {
                                      setState(() {
                                        lang = 'en';
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15.h),
                          ],
                        ),
                      ),
                      SizedBox(height: kSpacingSmall.h),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: MainColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(kRadiusMedium.r),
                          ),
                          minimumSize: Size(
                            double.infinity,
                            55.h,
                          ),
                        ),
                        onPressed: () {
                          if (lang != null) {
                            TranslationUtil.changeLang(lang: lang!);
                            Get.back();
                          } else {
                            Get.snackbar(
                              LanguageStrings.error,
                              "",
                              backgroundColor: MainColors.errorColor(context),
                              colorText: MainColors.whiteColor,
                            );
                          }
                        },
                        child: Text(
                          "${LanguageStrings.save} ${LanguageStrings.language}",
                          style: TextStyles.mediumLabelTextStyle(context).copyWith(
                            color: MainColors.whiteColor,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: kSpacingLarge.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(25.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButtonComponent(
                onTap: () => Get.back(),
                iconLink: ResourceManager.getAssetResource(closeIcon, type: ResourceType.svg),
                buttonWidth: 23.r,
                buttonHeight: 23.r,
                iconWidth: 15.r,
                iconHeight: 15.r,
                backgroundColor: MainColors.disableColor(context)?.withOpacity(0.5),
                iconColor: MainColors.whiteColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
