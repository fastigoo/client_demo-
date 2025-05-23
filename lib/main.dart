import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learning/core/helper/translation_util.dart';
import 'package:learning/core/localization/translation.dart';
import 'package:learning/core/localization/translation_reader.dart';
import 'package:learning/core/services/notification_service.dart';
import 'package:learning/core/services/storage_manager.dart';
import 'package:learning/core/styles/theme_styles.dart';
import 'package:learning/injection.dart';
import 'package:learning/routes/app_pages.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await StorageManager.initStorage();
  await NotificationService().init();
  await injectionInit();
  await TranslationReader.initialize();
  await TranslationUtil.initialize();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

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
            translations: Translation(),
            locale: TranslationUtil.currentLang,
            fallbackLocale: const Locale('en'),
            // themeMode: ThemeUtil.currentTheme,
            themeMode: ThemeMode.light,
            theme: ThemeStyles.lightTheme,
            darkTheme: ThemeStyles.darkTheme,
            builder: (context, child) {
              final locale = Get.locale ?? Get.fallbackLocale;
              final isRTL = locale?.languageCode == 'ar';
              return Directionality(
                textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
                child: child!,
              );
            },
            // builder: EasyLoading.init(),
          ),
        );
      },
    );
  }
}
