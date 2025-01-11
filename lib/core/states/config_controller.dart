import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ConfigController extends GetxController {
  String? appVersion;

  Future<void> getPackageVersion() async {
    // appVersion = await AppVersionInfoService.getAppVersion();
    // update([GetBuildersIdsConstants.splashVersionText]);
  }

  // GeneralSettingsModel? generalSettingsData;
  // Future<void> getGeneralSettingsData() async {
  //   await ConfigProvider().generalSettings(onLoading: () {}, onFinal: () {}).then((value) {
  //     if (value != null) {
  //       generalSettingsData = value;
  //     }
  //   });
  // }
  //
  // GeneralInfoModel? generalInfosData;
  // Future<void> getGeneralInfosData() async {
  //   await ConfigProvider().generalInfo(onLoading: () {}, onFinal: () {}).then((value) {
  //     if (value != null) {
  //       print(value.ccpInfo);
  //       generalInfosData = value;
  //     }
  //   });
  // }

  initialize() async {
    await getPackageVersion();
    // await getGeneralSettingsData();
    // await getGeneralInfosData();
  }

  String selectedAppLang = Get.locale?.languageCode ?? 'ar';

  bool saveAppLangLoading = false;
  void changeSaveAppLangLoading(bool loading) {
    saveAppLangLoading = loading;
    //update([GetBuildersIdsConstants.profileAppLangWindowButton]);
  }

  void changeSelectedAppLang(String lang) {
    selectedAppLang = lang;
    SystemNavigator.pop();
    // update([GetBuildersIdsConstants.profileAppLangWindowList]);
  }

  void saveAppLang() {
    // TranslationUtil.changeLang(lang: selectedAppLang);
    Get.back();
  }
}
