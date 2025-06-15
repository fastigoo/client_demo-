import 'package:flutter/material.dart';
import 'package:client/core/styles/main_colors.dart';

class ThemeStyles {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: MainColors.primaryColor,
    scaffoldBackgroundColor: LightColors.backgroundColor,
    cardColor: LightColors.cardColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: MainColors.primaryColor,
    ),
    splashColor: MainColors.primaryColor,
    highlightColor: MainColors.primaryColor,
    buttonTheme: ButtonThemeData(
      splashColor: MainColors.primaryColor,
      highlightColor: MainColors.primaryColor,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: MainColors.primaryColor,
        primary: MainColors.primaryColor,
      ),
    ),
    extensions: <ThemeExtension<dynamic>>[
      const ColorsStyles(
        backgroundColor: LightColors.backgroundColor,
        textColor: LightColors.textColor,
        disableColor: LightColors.disableColor,
        errorColor: LightColors.errorColor,
        infoColor: LightColors.infoColor,
        inputColor: LightColors.inputColor,
        successColor: LightColors.successColor,
        warningColor: LightColors.warningColor,
        shadowColor: LightColors.shadowColor,
        cardColor: LightColors.cardColor,
        //fullLogo: LightColors.fullLogo,
        //iconLogo: LightColors.iconLogo,
      ),
    ],
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: MainColors.primaryColor).copyWith(
          background: LightColors.backgroundColor,
        ),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: MainColors.primaryColor,
    scaffoldBackgroundColor: DarkColors.backgroundColor,
    cardColor: DarkColors.cardColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: MainColors.primaryColor,
    ),
    splashColor: MainColors.primaryColor,
    highlightColor: MainColors.primaryColor,
    buttonTheme: ButtonThemeData(
      splashColor: MainColors.primaryColor,
      highlightColor: MainColors.primaryColor,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: MainColors.primaryColor,
        primary: MainColors.primaryColor,
      ),
    ),
    extensions: <ThemeExtension<dynamic>>[
      const ColorsStyles(
        backgroundColor: DarkColors.backgroundColor,
        textColor: DarkColors.textColor,
        disableColor: DarkColors.disableColor,
        errorColor: DarkColors.errorColor,
        infoColor: DarkColors.infoColor,
        inputColor: DarkColors.inputColor,
        successColor: DarkColors.successColor,
        warningColor: DarkColors.warningColor,
        shadowColor: DarkColors.shadowColor,
        cardColor: DarkColors.cardColor,
        //fullLogo: DarkColors.fullLogo,
        //iconLogo: DarkColors.iconLogo,
      ),
    ],
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: MainColors.primaryColor).copyWith(
          background: DarkColors.backgroundColor,
        ),
  );
}
