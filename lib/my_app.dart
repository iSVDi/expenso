import 'package:flutter/material.dart';
import 'modules/main/views/main_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainView(),
      routes: {
        "/home": (context) => const MainView(),
      },
    );
  }
}
