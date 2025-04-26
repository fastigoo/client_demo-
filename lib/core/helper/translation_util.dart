import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning/core/resources/storage_keys.dart';
import 'package:learning/core/services/storage_manager.dart';

class TranslationUtil {
  static Locale? currentLang = const Locale('en');

  static void changeLang({required String lang}) {
    StorageManager.instance.setString(key: StorageKey.languageKey, value: lang);
    Locale? newLocale = Locale(lang);
    if (newLocale != null) {
      Get.updateLocale(newLocale);
      currentLang = newLocale;
      // home page
      // profile page
    } else {
      print('Invalid locale: $lang');
    }
  }

  static Future<void> initialize() async {
    await Future.delayed(Duration(milliseconds: 100));
    String lang = StorageManager.instance.getStringValue(key: StorageKey.languageKey) ?? 'ar';
    try {
      Locale? newLocale = Locale(lang);
      if (newLocale != null) {
        Get.updateLocale(newLocale);
        currentLang = newLocale;
      } else {
        print('Invalid locale: $lang');
      }
    } catch (e) {
      print('Error initializing translation: $e');
    }
  }

  static bool isRtl() {
    return currentLang?.languageCode == 'ar' || currentLang?.languageCode == 'he';
  }
}
