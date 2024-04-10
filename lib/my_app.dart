import 'package:expenso/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'modules/main/views/main_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = ThemeProvider();
    return MaterialApp(
      theme: themeProvider.getTheme(),
      darkTheme: themeProvider.getDarkTheme(),
      home: const MainView(),
      routes: {
        "/home": (context) => const MainView(),
      },
    );
  }
}
