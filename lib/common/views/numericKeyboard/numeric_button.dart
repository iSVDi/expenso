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
    var textStyle = Theme.of(context).textTheme.headlineLarge;
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
