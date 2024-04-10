//TODO move to separate file
import 'package:flutter/material.dart';

extension AppTextTheme on TextTheme {
  ///* SF Pro Light 50
  TextStyle get appLargeTitle =>
      const TextStyle(fontSize: 50, fontWeight: FontWeight.w300);

  ///* SF Pro Light 40
  TextStyle get appTitle1 => const TextStyle(fontSize: 40);

  ///* SF Pro Light 30
  TextStyle get appTitle2 =>
      const TextStyle(fontSize: 30, fontWeight: FontWeight.w400);

  ///* SF Pro Light 24
  TextStyle get appTitle3 =>
      const TextStyle(fontSize: 24, fontWeight: FontWeight.w200);

  ///* SF Pro Regular 18
  TextStyle get appHeadline =>
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w500);

  ///* SF Pro Light 18
  TextStyle get appBody =>
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w300);

  ///* SF Pro Regular 14
  TextStyle get appLabel => const TextStyle(fontSize: 14);

  ///* SF Pro Regular 12
  TextStyle get appSubhead =>
      const TextStyle(fontSize: 12, fontWeight: FontWeight.w200);
}
