import 'package:flutter/material.dart';

// TODO check how need set colors in flutter docs
class AppColors {
  static const appBlack = Colors.black;
  static const appWhite = Colors.white;

  static const appGreen = Color.fromRGBO(0, 133, 150, 1);
  static const appDisabledGreen = Color.fromRGBO(120, 186, 195, 1);
  static const appNumericKeyboardColor = Color.fromRGBO(238, 238, 238, 1);
  static const appTimerTextColor = Color.fromRGBO(120, 186, 195, 1);

  static List<Color> getCategoryColors() {
    return [
      Colors.purple,
      Colors.orange,
      Colors.green,
      Colors.red,
      Colors.blue,
      Colors.yellow,
      Colors.lightBlue,
      Colors.pink,
    ];
  }
}
