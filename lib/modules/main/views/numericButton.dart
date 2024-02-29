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
    return Center(
        child: TextButton(
            onPressed: () {
              callback();
            },
            child: Text(
              title,
              style: const TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            )));
  }
}
