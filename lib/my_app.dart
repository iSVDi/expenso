import 'package:expenso/extensions/app_colors.dart';
import 'package:flutter/material.dart';
import 'modules/main/views/main_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _getTheme(),
      darkTheme: _getDarkTheme(),
      home: const MainView(),
      routes: {
        "/home": (context) => const MainView(),
      },
    );
  }

  ThemeData _getTheme() {
    return ThemeData(
      bottomSheetTheme:
          const BottomSheetThemeData(surfaceTintColor: AppColors.appWhite),
      appBarTheme: const AppBarTheme(surfaceTintColor: AppColors.appWhite),
      fontFamily: "SF Pro",
      colorScheme: _getColorScheme(),
      textTheme: const TextTheme(),
    );
  }

  ThemeData _getDarkTheme() {
    return ThemeData(
      bottomSheetTheme:
          const BottomSheetThemeData(surfaceTintColor: AppColors.appBlack),
      appBarTheme: const AppBarTheme(surfaceTintColor: AppColors.appBlack),
      fontFamily: "SF Pro",
      colorScheme: _getDarkColorScheme(),
      textTheme: const TextTheme(),
    );
  }

//TODO implement
  ColorScheme _getColorScheme() {
    return const ColorScheme.light(primary: AppColors.appGreen);
  }

  ColorScheme _getDarkColorScheme() {
    return const ColorScheme.dark(primary: AppColors.appDarkGreen);
  }
}
