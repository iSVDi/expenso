import 'package:flutter/material.dart';
import "numericButton.dart";

class OnScreenNumericKeyboard extends StatelessWidget {
  final Size size;

  const OnScreenNumericKeyboard({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _getColumn(),
      height: size.height,
      width: size.width,
    );
  }

  Widget _getColumn() {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      _getNumericButtonRow(["7", "8", "9"]),
      _getNumericButtonRow(["4", "5", "6"]),
      _getNumericButtonRow(["1", "2", "3"]),
      _getNumericButtonRow(["", "0", "."]),
    ]);
  }

  Row _getNumericButtonRow(List<String> titles) {
    var buttons = titles.map((e) {
      return _getNumericButton(e);
    }).toList();
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround, children: buttons);
  }

  Widget _getNumericButton(String title) {
    var button = NumericButton(
        title: title,
        callback: () {
          _buttonHandler(title);
        });
    return button;
  }

//TODO: implement
  void _buttonHandler(String title) {
    print(title);
  }
}
