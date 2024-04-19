import 'package:flutter/material.dart';

import 'package:expenso/theme/text_theme_provider.dart';

//TODO implement func for get additionals colors for both themes
class ThemeProvider {
  final _fontFamily = "SF Pro";

  ThemeData getTheme() {
    var colorScheme = _getColorScheme();

    var textTheme = AppTextThemeProvider(primaryColor: colorScheme.primary);
    var additionalColors = const AdditionalColors(
      background1: Color.fromRGBO(238, 238, 238, 1),
      dotInactiveColor: Color.fromRGBO(221, 221, 221, 1),
    );

    var dividerColors = const DividerColors(
      keyboard: Color.fromRGBO(144, 144, 144, 1),
      history: Color.fromRGBO(238, 238, 238, 1),
      historyFirstSection: Color.fromRGBO(144, 144, 144, 1),
      welcome: Color.fromRGBO(144, 144, 144, 1),
    );

    return ThemeData(
      bottomSheetTheme: const BottomSheetThemeData(
        surfaceTintColor: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.white,
      ),
      fontFamily: _fontFamily,
      colorScheme: colorScheme,
      textTheme: textTheme.getTextTheme(),
      extensions: [additionalColors, dividerColors],
    );
  }

  ThemeData getDarkTheme() {
    var colorScheme = _getDarkColorScheme();

    var textTheme = AppTextThemeProvider(primaryColor: colorScheme.primary);
    var additionalColors = const AdditionalColors(
      background1: Color.fromRGBO(43, 43, 43, 1),
      dotInactiveColor: Color.fromRGBO(221, 221, 221, 1),
    );

    var dividerColors = const DividerColors(
      keyboard: Color.fromRGBO(34, 34, 34, 1),
      history: Color.fromRGBO(30, 30, 30, 1),
      historyFirstSection: Color.fromRGBO(144, 144, 144, 1),
      welcome: Color.fromRGBO(144, 144, 144, 1),
    );

    return ThemeData(
      bottomSheetTheme: const BottomSheetThemeData(
        surfaceTintColor: Color.fromRGBO(34, 34, 34, 1),
      ),
      appBarTheme: const AppBarTheme(
        surfaceTintColor: Color.fromRGBO(34, 34, 34, 1),
      ),
      fontFamily: _fontFamily,
      colorScheme: _getDarkColorScheme(),
      textTheme: textTheme.getTextTheme(),
      extensions: [
        additionalColors,
        dividerColors,
      ],
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
}

class DividerColors extends ThemeExtension<DividerColors> {
  const DividerColors({
    required this.keyboard,
    required this.history,
    required this.historyFirstSection,
    required this.welcome,
  });

  final Color keyboard;
  final Color history;
  final Color historyFirstSection;
  final Color welcome;

  @override
  ThemeExtension<DividerColors> copyWith({
    Color? keyboard,
    Color? history,
    Color? historyFirstSection,
    Color? welcome,
  }) {
    return DividerColors(
      keyboard: keyboard ?? this.keyboard,
      history: history ?? this.history,
      historyFirstSection: historyFirstSection ?? this.historyFirstSection,
      welcome: welcome ?? this.welcome,
    );
  }

  @override
  ThemeExtension<DividerColors> lerp(
      covariant ThemeExtension<DividerColors>? other, double t) {
    if (other is! DividerColors) {
      return this;
    }
    return DividerColors(
      keyboard: Color.lerp(keyboard, other.keyboard, t) ?? keyboard,
      history: Color.lerp(history, other.history, t) ?? history,
      historyFirstSection:
          Color.lerp(historyFirstSection, other.historyFirstSection, t) ??
              historyFirstSection,
      welcome: Color.lerp(welcome, other.welcome, t) ?? welcome,
    );
  }
}

class AdditionalColors extends ThemeExtension<AdditionalColors> {
  const AdditionalColors({
    required this.background1,
    required this.dotInactiveColor,
  });

  final Color background1;
  final Color dotInactiveColor;

  @override
  ThemeExtension<AdditionalColors> copyWith({
    Color? background1,
    Color? dotColor,
  }) {
    return AdditionalColors(
      background1: background1 ?? this.background1,
      dotInactiveColor: dotColor ?? this.dotInactiveColor,
    );
  }

  @override
  ThemeExtension<AdditionalColors> lerp(
      covariant ThemeExtension<AdditionalColors>? other, double t) {
    if (other is! AdditionalColors) {
      return this;
    }
    return AdditionalColors(
      background1: Color.lerp(background1, other.background1, t) ?? background1,
      dotInactiveColor:
          Color.lerp(dotInactiveColor, other.dotInactiveColor, t) ??
              dotInactiveColor,
    );
  }
}
