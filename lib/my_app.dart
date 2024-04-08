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
      textTheme: const TextTheme(),
    );
  }
}

extension AppTextTheme on TextTheme {
  ///* SF Pro Light 50
  TextStyle get appLargeTitle => const TextStyle(
        fontSize: 50,
        color: AppColors.appBlack,
        fontWeight: FontWeight.w300,
      );

  ///* SF Pro Light 40
  TextStyle get appTitle1 =>
      const TextStyle(fontSize: 40, color: AppColors.appBlack);

  ///* SF Pro Light 30
  TextStyle get appTitle2 => const TextStyle(
        fontSize: 30,
        color: AppColors.appBlack,
        fontWeight: FontWeight.w400,
      );

  ///* SF Pro Light 24
  TextStyle get appTitle3 => const TextStyle(
        fontSize: 24,
        color: AppColors.appBlack,
        fontWeight: FontWeight.w200,
      );

  ///* SF Pro Regular 18
  TextStyle get appHeadline => const TextStyle(
        fontSize: 18,
        color: AppColors.appBlack,
        fontWeight: FontWeight.w500,
      );

  ///* SF Pro Light 18
  TextStyle get appBody => const TextStyle(
        fontSize: 18,
        color: AppColors.appGreen,
        fontWeight: FontWeight.w300,
      );

  ///* SF Pro Regular 14
  TextStyle get appLabel =>
      const TextStyle(fontSize: 14, color: AppColors.appBlack);

  ///* SF Pro Regular 12
  TextStyle get appSubhead => const TextStyle(
        fontSize: 12,
        color: AppColors.appGreen,
        fontWeight: FontWeight.w200,
      );
}
