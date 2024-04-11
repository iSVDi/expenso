// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expenso/extensions/app_colors.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final BorderSide borderSide;
  final Function() onPressed;

  const RoundedButton({
    Key? key,
    required this.text,
    required this.textColor,
    this.backgroundColor = AppColors.appWhite,
    this.borderSide = BorderSide.none,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var buttonShape = MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: borderSide,
      ),
    );
    var buttonStyle = ButtonStyle(
        surfaceTintColor: MaterialStatePropertyAll(backgroundColor),
        backgroundColor: MaterialStatePropertyAll(backgroundColor),
        shape: buttonShape);

    var textStyle = Theme.of(context)
        .textTheme
        .headlineSmall
        ?.copyWith(color: textColor, fontWeight: FontWeight.w300);

    double horizontalPadding = 5;
    double verticalPadding = 12;
    var child = Padding(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        child: Text(text, style: textStyle));
    var button =
        ElevatedButton(onPressed: onPressed, style: buttonStyle, child: child);
    return button;
  }
}
