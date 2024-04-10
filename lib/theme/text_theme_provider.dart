import 'package:expenso/extensions/app_colors.dart';
import 'package:flutter/material.dart';

abstract class TextThemeProvider {
  final displayMedium = const TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.w300,
  );
  final displaySmall = const TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w200,
  );
  final headlineLarge = const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w400,
  );
  final headlineSmall = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w200,
  );

  final labelLarge = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  late TextStyle titleMedium;
  late TextStyle titleLarge;
  late TextStyle labelMedium;

  TextThemeProvider() {
    labelMedium =
        const TextStyle(fontSize: 12, fontWeight: FontWeight.w200).copyWith(
      color: _getLabelMediumColor(),
    );
    titleLarge =
        const TextStyle(fontSize: 18, fontWeight: FontWeight.w500).copyWith(
      color: _getTitleLargeColor(),
    );
    titleMedium =
        const TextStyle(fontSize: 18, fontWeight: FontWeight.w300).copyWith(
      color: _getTitleMediumColor(),
    );
  }

  TextTheme getTextTheme() {
    var theme = TextTheme(
        displayMedium: displayMedium,
        displaySmall: displaySmall,
        headlineLarge: headlineLarge,
        headlineSmall: headlineSmall,
        titleLarge: titleLarge,
        titleMedium: titleMedium,
        labelLarge: labelLarge,
        labelMedium: labelMedium);
    return theme;
  }

  Color _getLabelMediumColor();
  Color _getTitleLargeColor();
  Color _getTitleMediumColor();
}

class LightTextThemeProvider extends TextThemeProvider {
  @override
  Color _getLabelMediumColor() => AppColors.appGreen;

  @override
  Color _getTitleLargeColor() => AppColors.appGreen;

  @override
  Color _getTitleMediumColor() => AppColors.appGreen;
}

class DarkTextThemeProvider extends TextThemeProvider {
  @override
  Color _getLabelMediumColor() => AppColors.appDarkGreen;

  @override
  Color _getTitleLargeColor() => AppColors.appDarkGreen;

  @override
  Color _getTitleMediumColor() => AppColors.appDarkGreen;
}
