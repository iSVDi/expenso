import 'package:expenso/theme/theme_extensions/additional_colors.dart';
import 'package:expenso/theme/theme_extensions/divider_colors.dart';
import 'package:flutter/material.dart';
import 'package:expenso/theme/text_theme_provider.dart';

class ThemeProvider {
  final _fontFamily = "SF Pro";

  ThemeData getTheme(bool isLightTheme) {
    var colorScheme = isLightTheme ? _getColorScheme() : _getDarkColorScheme();
    var textTheme = AppTextThemeProvider(primaryColor: colorScheme.primary);

    var bottomSheetThemeData = BottomSheetThemeData(
      surfaceTintColor:
          isLightTheme ? Colors.white : const Color.fromRGBO(34, 34, 34, 1),
    );
    var appBarTheme = AppBarTheme(
      surfaceTintColor:
          isLightTheme ? Colors.white : const Color.fromRGBO(34, 34, 34, 1),
    );

    var additionalColors = _getAdditionalColors(isLightTheme);
    var dividerColors = _getDividerColors(isLightTheme);

    return ThemeData(
      colorScheme: colorScheme,
      textTheme: textTheme.getTextTheme(),
      bottomSheetTheme: bottomSheetThemeData,
      appBarTheme: appBarTheme,
      fontFamily: _fontFamily,
      extensions: [additionalColors, dividerColors],
    );
  }

  ColorScheme _getColorScheme() {
    return const ColorScheme.light(
      primary: Color.fromRGBO(0, 133, 150, 1),
      onPrimary: Color.fromRGBO(120, 186, 195, 1),
      surface: Colors.white,
      surfaceTint: Colors.white,
    );
  }

  ColorScheme _getDarkColorScheme() {
    return const ColorScheme.dark(
      primary: Color.fromRGBO(32, 220, 217, 1),
      onPrimary: Color.fromRGBO(0, 133, 150, 1),
      surface: Color.fromRGBO(34, 34, 34, 1),
      surfaceTint: Color.fromRGBO(34, 34, 34, 1),
      background: Color.fromRGBO(34, 34, 34, 1),
    );
  }

  AdditionalColors _getAdditionalColors(bool isLightMode) {
    var additionalColors = AdditionalColors(
      background1: isLightMode
          ? const Color.fromRGBO(238, 238, 238, 1)
          : const Color.fromRGBO(43, 43, 43, 1),
      dotInactiveColor: const Color.fromRGBO(221, 221, 221, 1),
      historyBarBackground: isLightMode
          ? const Color.fromRGBO(0, 133, 150, 1)
          : const Color.fromRGBO(25, 25, 25, 1),
    );
    return additionalColors;
  }

  DividerColors _getDividerColors(bool isLightMode) {
    var dividerColors = DividerColors(
        keyboard: isLightMode
            ? const Color.fromRGBO(144, 144, 144, 1)
            : const Color.fromRGBO(34, 34, 34, 1),
        history: isLightMode
            ? const Color.fromRGBO(238, 238, 238, 1)
            : const Color.fromRGBO(25, 25, 25, 1),
        historyFirstSection: const Color.fromRGBO(144, 144, 144, 1),
        welcome: const Color.fromRGBO(144, 144, 144, 1));
    return dividerColors;
  }
}
