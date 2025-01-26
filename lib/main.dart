import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learning/core/helper/theme_util.dart';
import 'package:learning/core/styles/theme_styles.dart';
import 'package:learning/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (BuildContext context, Widget? child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: GetMaterialApp(
            transitionDuration: const Duration(milliseconds: 300),
            defaultTransition: Transition.noTransition,
            debugShowCheckedModeBanner: false,
            title: "Fasti Goo",
            initialRoute: AppPages.RESTO,
            getPages: AppPages.routes,
            // translations: Translation(),
            // locale: TranslationUtil.currentLang,
            // fallbackLocale: const Locale('fr'),
            // themeMode: ThemeUtil.currentTheme,
            themeMode: ThemeMode.dark,
            theme: ThemeStyles.lightTheme,
            darkTheme: ThemeStyles.darkTheme,
            // builder: EasyLoading.init(),
          ),
        );
      },
    );
  }
}
