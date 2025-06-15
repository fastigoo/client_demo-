import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:client/core/components/inputs/switch_component.dart';
import 'package:client/core/components/popups/bottm_sheet_component.dart';
import 'package:client/core/helper/theme_util.dart';
import 'package:client/core/resources/constants.dart';
import 'package:client/core/resources/images.dart';
import 'package:client/core/resources/language_strings.dart';
import 'package:client/core/services/resource_manager.dart';
import 'package:client/core/styles/main_colors.dart';
import 'package:client/core/styles/text_styles.dart';
import 'package:client/features/settings/presentation/states/settings_controller.dart';
import 'package:client/features/settings/presentation/widgets/change_language_component.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LanguageStrings.settings,
          style: TextStyles.mediumLabelTextStyle(context).copyWith(
            color: Colors.white,
          ),
        ),
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: kSpacingMedium.w,
          vertical: kSpacingMedium.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${LanguageStrings.themeMode}: ",
              style: TextStyles.mediumBodyTextStyle(context),
            ),
            SizedBox(height: kSpacingSmall.h),
            GestureDetector(
              onTap: (){
                if (ThemeUtil.isDarkMode) {
                  ThemeUtil.changeTheme(theme: ThemeMode.light);
                } else {
                  ThemeUtil.changeTheme(theme: ThemeMode.dark);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: kSpacingMedium.w,
                  vertical: kSpacingMedium.h,
                ),
                decoration: BoxDecoration(
                  color: MainColors.cardColor(context),
                  borderRadius: BorderRadius.circular(kSpacingSmall.w),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LanguageStrings.theme,
                      style: TextStyles.mediumBodyTextStyle(context),
                    ),
                    SwitchComponent(
                      enable: ThemeUtil.isDarkMode,
                      onChange: (value) {
                        if (ThemeUtil.isDarkMode) {
                          ThemeUtil.changeTheme(theme: ThemeMode.light);
                        } else {
                          ThemeUtil.changeTheme(theme: ThemeMode.dark);
                        }
                      },
                      activeIconPath: ResourceManager.getAssetResource(moonIcon, type: ResourceType.svg),
                      inactiveIconPath: ResourceManager.getAssetResource(moonIcon, type: ResourceType.svg),
                      width: 42.r,
                      height: 25.r,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: kSpacingMedium.h),
            Text("${LanguageStrings.language}: ", style: TextStyles.mediumBodyTextStyle(context)),
            SizedBox(height: kSpacingSmall.h),
            GestureDetector(
              onTap: (){
                BottomSheetComponent.show(
                  dismissible: true,
                  context,
                  body: const ChangeAppLangWindowComponent(),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: kSpacingMedium.w,
                  vertical: kSpacingMedium.h,
                ),
                decoration: BoxDecoration(
                  color: MainColors.cardColor(context),
                  borderRadius: BorderRadius.circular(kSpacingSmall.w),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LanguageStrings.language,
                      style: TextStyles.mediumBodyTextStyle(context),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
