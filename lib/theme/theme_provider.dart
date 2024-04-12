// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:expenso/theme/text_theme_provider.dart';
import 'package:flutter/material.dart';

import 'package:expenso/extensions/app_colors.dart';

class ThemeProvider {
  final _fontFamily = "SF Pro";

  ThemeData getTheme() {
    var textTheme = LightTextThemeProvider();
    return ThemeData(
      bottomSheetTheme: const BottomSheetThemeData(
        surfaceTintColor: AppColors.appWhite,
      ),
      appBarTheme: const AppBarTheme(
        surfaceTintColor: AppColors.appWhite,
      ),
      fontFamily: _fontFamily,
      colorScheme: _getColorScheme(),
      textTheme: textTheme.getTextTheme(),
    );
  }

  ThemeData getDarkTheme() {
    var textTheme = DarkTextThemeProvider();
    return ThemeData(
      bottomSheetTheme: const BottomSheetThemeData(
        surfaceTintColor: AppColors.appBlack,
      ),
      appBarTheme: const AppBarTheme(
        surfaceTintColor: AppColors.appBlack,
      ),
      fontFamily: _fontFamily,
      colorScheme: _getDarkColorScheme(),
      textTheme: textTheme.getTextTheme(),
    );
  }

  ColorScheme _getColorScheme() {
    return const ColorScheme.light(primary: AppColors.appGreen);
  }

  ColorScheme _getDarkColorScheme() {
    return const ColorScheme.dark(
        primary: AppColors.appDarkGreen, background: AppColors.appBlack);
  }
}
