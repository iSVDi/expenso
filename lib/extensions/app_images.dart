import "package:flutter/material.dart";

enum AppImages {
  barChartIcon,
  settingsIcon,
  donutModeIcon,
  barModeIcon,
  calendarIcon,
  refreshIcon,
  barChartPlug,
  donutChartPlug
}

extension AssetsImage on AppImages {
  Image assetsImage({Color? color, double? width, double? height}) {
    return Image.asset(
      "assets/$name.png",
      color: color,
      width: width,
      height: height,
    );
  }
}
