import 'package:expenso/common/constants.dart';
import 'package:expenso/extensions/app_colors.dart';
import 'package:flutter/material.dart';

class ViewFactory {
  //TODO rewrite as widget
  static Padding getDoneButton(BuildContext context, Function()? onPressed) {
    var buttonColor =
        onPressed == null ? AppColors.appDisabledGreen : AppColors.appGreen;
    ;

    var icon = const Icon(Icons.done, color: AppColors.appWhite);
    var sideSize = Constants.sizeFrom(context).width * 0.235;
    var buttonStyleSize = Size(sideSize, sideSize);

    var buttonStyle = ButtonStyle(
        minimumSize: MaterialStatePropertyAll(buttonStyleSize),
        backgroundColor: MaterialStateProperty.all(buttonColor));

    var button = IconButton(
        color: AppColors.appGreen,
        disabledColor: AppColors.appDisabledGreen,
        onPressed: onPressed,
        icon: icon,
        iconSize: 40,
        style: buttonStyle);
    return Padding(
      padding: const EdgeInsets.only(right: 5, bottom: 5),
      child: button,
    );
  }
}
