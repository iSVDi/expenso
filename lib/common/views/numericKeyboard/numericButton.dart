import "package:expenso/extensions/appColors.dart";
import "package:flutter/material.dart";

class NumericButton extends StatelessWidget {
  final String title;
  final Function callback;

  const NumericButton({
    Key? key,
    required this.title,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
        fontSize: 30, color: AppColors.appBlack, fontWeight: FontWeight.w400);
    var text = Text(title, style: textStyle, textAlign: TextAlign.center);
    var textButton = TextButton(
        onPressed: () {
          callback();
        },
        child: text);
    var center = Center(child: textButton);
    return center;
  }
}
