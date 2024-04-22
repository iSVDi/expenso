import 'package:flutter/material.dart';

class AppTextThemeProvider {
  final displayLarge = const TextStyle(
    fontSize: 70,
    fontWeight: FontWeight.w100,
  );

  final displayMedium = const TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.w300,
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
  late TextStyle displaySmall;
  late TextStyle titleMedium;
  late TextStyle titleLarge;
  late TextStyle labelMedium;

  AppTextThemeProvider({required primaryColor}) {
    displaySmall = const TextStyle(fontSize: 40, fontWeight: FontWeight.w200)
        .copyWith(color: primaryColor);
    labelMedium = const TextStyle(fontSize: 12, fontWeight: FontWeight.w200)
        .copyWith(color: primaryColor);
    titleLarge = const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)
        .copyWith(color: primaryColor);
    titleMedium = const TextStyle(fontSize: 18, fontWeight: FontWeight.w300)
        .copyWith(color: primaryColor);
  }

  TextTheme getTextTheme() {
    var theme = TextTheme(
        displayLarge: displayLarge,
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
}
