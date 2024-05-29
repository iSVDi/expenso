import 'package:expenso/gen/fonts.gen.dart';
import 'package:expenso/theme/theme_extensions/additional_colors.dart';
import 'package:expenso/theme/theme_extensions/divider_colors.dart';
import 'package:flutter/material.dart';
import 'package:expenso/theme/text_theme_provider.dart';

class ThemeProvider {
  ThemeData getTheme() {
    var colorScheme = _getColorScheme();
    var textTheme = AppTextThemeProvider(primaryColor: colorScheme.primary);

    var bottomSheetThemeData =
        const BottomSheetThemeData(surfaceTintColor: Colors.white);
    var appBarTheme = const AppBarTheme(surfaceTintColor: Colors.white);

    var additionalColors = _getAdditionalColors(forLightMode: true);
    var dividerColors = _getDividerColors(forLightMode: true);

    return ThemeData(
      colorScheme: colorScheme,
      textTheme: textTheme.getTextTheme(),
      bottomSheetTheme: bottomSheetThemeData,
      appBarTheme: appBarTheme,
      fontFamily: FontFamily.sFPro,
      extensions: [additionalColors, dividerColors],
    );
  }

  ThemeData getDarkTheme() {
    var colorScheme = _getDarkColorScheme();
    var textTheme = AppTextThemeProvider(primaryColor: colorScheme.primary);

    var bottomSheetThemeData = const BottomSheetThemeData(
        surfaceTintColor: Color.fromRGBO(34, 34, 34, 1));
    var appBarTheme =
        const AppBarTheme(surfaceTintColor: Color.fromRGBO(34, 34, 34, 1));
    var additionalColors = _getAdditionalColors(forLightMode: false);
    var dividerColors = _getDividerColors(forLightMode: false);

    return ThemeData(
      colorScheme: colorScheme,
      textTheme: textTheme.getTextTheme(),
      bottomSheetTheme: bottomSheetThemeData,
      appBarTheme: appBarTheme,
      fontFamily: FontFamily.sFPro,
      extensions: [additionalColors, dividerColors],
    );
  }

  ColorScheme _getColorScheme() {
    return const ColorScheme.light(
      primary: Color.fromRGBO(0, 133, 150, 1),
      onPrimary: Color.fromRGBO(120, 186, 195, 1),
      surface: Colors.white,
      surfaceTint: Colors.white,
      surfaceVariant: Color.fromRGBO(238, 238, 238, 1),
    );
  }

  ColorScheme _getDarkColorScheme() {
    return const ColorScheme.dark(
      primary: Color.fromRGBO(32, 220, 217, 1),
      onPrimary: Color.fromRGBO(0, 133, 150, 1),
      surface: Color.fromRGBO(34, 34, 34, 1),
      surfaceTint: Color.fromRGBO(34, 34, 34, 1),
      surfaceVariant: Color.fromRGBO(43, 43, 43, 1),
      background: Color.fromRGBO(34, 34, 34, 1),
    );
  }

  AdditionalColors _getAdditionalColors({required bool forLightMode}) {
    var additionalColors = AdditionalColors(
      dotInactiveColor: const Color.fromRGBO(221, 221, 221, 1),
      historyBarBackground: forLightMode
          ? const Color.fromRGBO(0, 133, 150, 1)
          : const Color.fromRGBO(25, 25, 25, 1),
    );
    return additionalColors;
  }

  DividerColors _getDividerColors({required bool forLightMode}) {
    var dividerColors = DividerColors(
        keyboard: forLightMode
            ? const Color.fromRGBO(144, 144, 144, 1)
            : const Color.fromRGBO(34, 34, 34, 1),
        history: forLightMode
            ? const Color.fromRGBO(238, 238, 238, 1)
            : const Color.fromRGBO(25, 25, 25, 1),
        historyFirstSection: const Color.fromRGBO(144, 144, 144, 1),
        welcome: const Color.fromRGBO(144, 144, 144, 1));
    return dividerColors;
  }
}
