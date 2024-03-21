import 'package:flutter/material.dart';

class ViewFactory {
  static Container getDoneButton(BuildContext context, Function()? onPressed) {
    return Container(
        padding: const EdgeInsets.only(right: 5, bottom: 5),
        child: IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.done),
            style: ButtonStyle(
                minimumSize: const MaterialStatePropertyAll(Size(88, 88)),
                backgroundColor:
                    MaterialStateProperty.all(Colors.greenAccent[400]))));
  }
}
