// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:expenso/theme/text_theme_provider.dart';
import 'package:flutter/material.dart';

//TODO setup dividers' themes (Check numeric keyboard divider color and history)
//TODO implement func for get additionals colors for both themes
class ThemeProvider {
  final _fontFamily = "SF Pro";

  ThemeData getTheme() {
    var colorScheme = _getColorScheme();
    var additionalColors = const AdditionalColors(
      background1: Color.fromRGBO(238, 238, 238, 1),
    );
    var textTheme = AppTextThemeProvider(primaryColor: colorScheme.primary);
    return ThemeData(
      dividerTheme:
          const DividerThemeData(color: Color.fromARGB(255, 84, 31, 31)),
      bottomSheetTheme: const BottomSheetThemeData(
        surfaceTintColor: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.white,
      ),
      fontFamily: _fontFamily,
      colorScheme: colorScheme,
      textTheme: textTheme.getTextTheme(),
      extensions: [additionalColors],
    );
  }

  ThemeData getDarkTheme() {
    var colorScheme = _getDarkColorScheme();
    var additionalColors = const AdditionalColors(
      background1: Color.fromRGBO(43, 43, 43, 1),
    );
    var textTheme = AppTextThemeProvider(primaryColor: colorScheme.primary);
    return ThemeData(
      dividerTheme:
          const DividerThemeData(color: Color.fromRGBO(34, 34, 34, 1)),
      bottomSheetTheme: const BottomSheetThemeData(
        surfaceTintColor: Color.fromRGBO(34, 34, 34, 1),
      ),
      appBarTheme: const AppBarTheme(
        surfaceTintColor: Color.fromRGBO(34, 34, 34, 1),
      ),
      fontFamily: _fontFamily,
      colorScheme: _getDarkColorScheme(),
      textTheme: textTheme.getTextTheme(),
      extensions: [additionalColors],
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

class AdditionalColors extends ThemeExtension<AdditionalColors> {
  const AdditionalColors({
    required this.background1,
  });

  final Color background1;

  @override
  ThemeExtension<AdditionalColors> copyWith({
    Color? background1,
  }) {
    return AdditionalColors(
      background1: background1 ?? this.background1,
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
    );
  }
}
