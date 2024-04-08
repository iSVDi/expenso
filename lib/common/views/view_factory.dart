import 'package:expenso/common/constants.dart';
import 'package:flutter/material.dart';

class ViewFactory {
  //TODO rewrite as widget
  static Padding getDoneButton(BuildContext context, Function()? onPressed) {
    var colorScheme = Theme.of(context).colorScheme;
    var buttonColor =
        onPressed == null ? colorScheme.onPrimary : colorScheme.primary;

    var icon = const Icon(Icons.done, color: Colors.white);
    var sideSize = Constants.sizeFrom(context).width * 0.235;
    var buttonStyleSize = Size(sideSize, sideSize);

    var buttonStyle = ButtonStyle(
        minimumSize: MaterialStatePropertyAll(buttonStyleSize),
        backgroundColor: MaterialStateProperty.all(buttonColor));

    var button = IconButton(
        color: colorScheme.primary,
        disabledColor: colorScheme.onPrimary,
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
