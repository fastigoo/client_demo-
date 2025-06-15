import 'package:client/core/helper/theme_util.dart';
import 'package:client/core/helper/translation_util.dart';
import 'package:client/core/localization/translation.dart';
import 'package:client/core/localization/translation_reader.dart';
import 'package:client/core/services/notification_service.dart';
import 'package:client/core/services/storage_manager.dart';
import 'package:client/core/states/internet_state.dart';
import 'package:client/core/styles/theme_styles.dart';
import 'package:client/firebase_options.dart';
import 'package:client/injection.dart';
import 'package:client/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await StorageManager.initStorage();
  await NotificationService().init();
  await injectionInit();
  await ThemeUtil.initialize();
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
  Get.put<InternetCheckerState>(InternetCheckerState());
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
            navigatorKey: Get.key,
            transitionDuration: const Duration(milliseconds: 300),
            defaultTransition: Transition.noTransition,
            debugShowCheckedModeBanner: false,
            title: "FastiiGo",
            initialRoute: AppPages.RESTO,
            getPages: AppPages.routes,
            translations: Translation(),
            locale: TranslationUtil.currentLang,
            fallbackLocale: const Locale('ar'),
            // themeMode: ThemeUtil.currentTheme,
            themeMode: ThemeUtil.currentTheme,
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
