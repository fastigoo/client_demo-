import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client/core/resources/storage_keys.dart';
import 'package:client/core/services/storage_manager.dart';

class TranslationUtil {
  static Locale? currentLang = const Locale('ar');

  static void changeLang({required String lang}) {
    StorageManager.instance.setString(key: StorageKey.languageKey, value: lang);
    Locale? newLocale = Locale(lang);
    Get.updateLocale(newLocale);
    currentLang = newLocale;
    // home page
    // profile page
  }

  static Future<void> initialize() async {
    await Future.delayed(const Duration(milliseconds: 100));
    String lang = StorageManager.instance.getStringValue(key: StorageKey.languageKey) ?? 'ar';
    try {
      Locale? newLocale = Locale(lang);
      Get.updateLocale(newLocale);
      currentLang = newLocale;
    } catch (e) {
      print('Error initializing translation: $e');
    }
  }

  static bool isRtl() {
    return currentLang?.languageCode == 'ar' || currentLang?.languageCode == 'he';
  }
}
