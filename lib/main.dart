import 'package:expenso/modules/main/mainView.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainView(),
      routes: {"/analyse": (context) => MainView()},
    );
  }
}
