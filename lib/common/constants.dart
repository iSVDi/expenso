import 'package:flutter/material.dart';

class Constants {
  static var keyboardHeightRatio = 0.43;

  static Size sizeFrom(BuildContext context) {
    return MediaQuery.of(context).size;
  }
}
