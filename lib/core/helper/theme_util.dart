import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:learning/core/resources/storage_keys.dart';
import 'package:learning/core/services/storage_manager.dart';

class ThemeUtil {
  static ThemeMode currentTheme = ThemeMode.light;

  static bool isDarkMode = false;

  static void changeTheme({required ThemeMode theme}) async {
    await StorageManager.instance.setString(key: StorageKey.themeKey, value: (theme == ThemeMode.dark) ? 'dark' : 'light');
    isDarkMode = theme == ThemeMode.dark;
    Get.changeThemeMode(theme);
    currentTheme = theme;
  }

  static void toggleTheme() {
    changeTheme(theme: isDarkMode ? ThemeMode.light : ThemeMode.dark);
  }

  static Future<void> initialize() async {
    String? theme = StorageManager.instance.getStringValue(key: StorageKey.themeKey);
    if (theme != null) {
      isDarkMode =
          StorageManager.instance.getStringValue(key: StorageKey.themeKey) == 'dark';
      currentTheme =
      (theme == 'dark')
          ? ThemeMode.dark
          : ThemeMode.light;
    } else {
      isDarkMode = SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
    }
  }
}
