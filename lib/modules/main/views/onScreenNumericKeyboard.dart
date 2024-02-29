import 'package:flutter/material.dart';
import "numericButton.dart";

enum ButtonType {
  point("."),
  zero("0"),
  one("1"),
  two("2"),
  three("3"),
  four("4"),
  five("5"),
  six("6"),
  seven("7"),
  eight("8"),
  nine("9"),
  empty(""),
  delete("x"),
  done("d");

  final String value;
  const ButtonType(this.value);
}

class OnScreenNumericKeyboard extends StatelessWidget {
  final Size size;

  const OnScreenNumericKeyboard({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _getKeyboard(),
      height: size.height,
      width: size.width,
    );
  }

  Widget _getKeyboard() {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      _getKeyboardHeader(),
      const Divider(
        thickness: 2,
        color: Colors.black,
      ),
      _getNumericKeyboard()
    ]);
  }

  Widget _getKeyboardHeader() {
    var dateLabel = Text(
      "15.06.2022\n12:56",
      style: TextStyle(color: Colors.greenAccent[400], fontSize: 18),
    );
    return Row(children: [dateLabel]);
  }

  Column _getNumericKeyboard() {
    var numerics = Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      _getNumericButtonRows([
        ButtonType.seven,
        ButtonType.eight,
        ButtonType.nine,
        ButtonType.delete
      ]),
      _getNumericButtonRows(
          [ButtonType.four, ButtonType.five, ButtonType.six, ButtonType.empty]),
      _getNumericButtonRows(
          [ButtonType.one, ButtonType.two, ButtonType.three, ButtonType.empty]),
      _getNumericButtonRows([
        ButtonType.empty,
        ButtonType.zero,
        ButtonType.point,
        ButtonType.done
      ])
    ]);
    return numerics;
  }

  Row _getNumericButtonRows(List<ButtonType> titles) {
    var buttons = titles.map((type) {
      switch (type) {
        case ButtonType.empty:
          return Expanded(child: _getEmptyButton());
        case ButtonType.done:
          return Expanded(child: _getDoneButton());
        case ButtonType.delete:
          return Expanded(child: _getDeleteButton());
        default:
          return Expanded(child: _getNumericButton(type.value));
      }
    }).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: buttons,
    );
  }

  Widget _getNumericButton(String title) {
    var button = NumericButton(
        title: title,
        callback: () {
          _buttonHandler(title);
        });
    return button;
  }

  IconButton _getDeleteButton() {
    return IconButton(
        onPressed: () {
          print("delete button pressed");
        },
        icon: Icon(Icons.arrow_back));
  }

  IconButton _getDoneButton() {
    return IconButton(
        onPressed: () {
          print("done button pressed");
        },
        icon: Icon(Icons.done),
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Colors.greenAccent[400])));
  }

  TextButton _getEmptyButton() {
    return const TextButton(onPressed: null, child: Text(""));
  }

//TODO: implement
  void _buttonHandler(String title) {
    print(title);
  }
}
