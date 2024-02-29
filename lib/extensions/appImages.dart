import "package:flutter/material.dart";

enum AppImages { barChartIcon, settingsIcon }

extension AssetsImage on AppImages {
  String get _getPath {
    switch (this) {
      case AppImages.barChartIcon:
        return "barChartIcon.png";
      case AppImages.settingsIcon:
        return "settingsIcon.png";
    }
  }

  Image get assetsImage {
    return Image.asset("assets/$_getPath");
  }
}
