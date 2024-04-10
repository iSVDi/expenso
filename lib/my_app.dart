import 'package:expenso/extensions/app_colors.dart';
import 'package:flutter/material.dart';
import 'modules/main/views/main_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _getTheme(),
      home: const MainView(),
      routes: {
        "/home": (context) => const MainView(),
      },
    );
  }

  ThemeData _getTheme() {
    return ThemeData(
      appBarTheme: const AppBarTheme(backgroundColor: AppColors.appWhite),
      scaffoldBackgroundColor: AppColors.appWhite,
      fontFamily: "SF Pro",
      // colorScheme: _getColorScheme(), //TODO implement
      textTheme: const TextTheme(),
    );
  }

//TODO implement
  // ColorScheme _getColorScheme() {
  // return const ColorScheme.light(
  //     primary: Color.fromRGBO(0, 133, 150, 1),
  //     onPrimary: Color.fromRGBO(120, 186, 195, 1),
  //     surface: Color.fromRGBO(238, 238, 238, 1));
  // }

  ColorScheme _getDarkColorScheme() {
    return const ColorScheme.dark();
  }
}

