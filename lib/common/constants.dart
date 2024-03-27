import 'package:flutter/material.dart';

class Constants {
  // TODO remove from constants
  static var keyboardHeightRatio = 0.43;

  static Size sizeFrom(BuildContext context) {
    return MediaQuery.of(context).size;
  }
}
