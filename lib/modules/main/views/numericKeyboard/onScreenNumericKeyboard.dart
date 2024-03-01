import 'package:flutter/material.dart';
import "numericButton.dart";
import 'package:expenso/modules/main/helpers/amountStringUpdater.dart';

enum NumericKeyboardButtonType {
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
  const NumericKeyboardButtonType(this.value);
}

class OnScreenNumericKeyboard extends StatefulWidget {
  final Size size;

  OnScreenNumericKeyboard({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OnScreenNumericKeyboard();
}

class _OnScreenNumericKeyboard extends State<OnScreenNumericKeyboard> {
  late Text amountLabel = _getAmountLabel("0");
  final AmountStringUpdater amountStringUpdator = AmountStringUpdater();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _getKeyboard(),
      height: widget.size.height,
      width: widget.size.width,
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

    var space = const SizedBox(width: 27);

    var header = Row(children: [dateLabel, space, amountLabel]);
    return Container(
        padding: const EdgeInsets.only(left: 32, right: 32), child: header);
  }

  Column _getNumericKeyboard() {
    var numerics = Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      _getNumericButtonRows([
        NumericKeyboardButtonType.seven,
        NumericKeyboardButtonType.eight,
        NumericKeyboardButtonType.nine,
        NumericKeyboardButtonType.delete
      ]),
      _getNumericButtonRows([
        NumericKeyboardButtonType.four,
        NumericKeyboardButtonType.five,
        NumericKeyboardButtonType.six,
        NumericKeyboardButtonType.empty
      ]),
      _getNumericButtonRows([
        NumericKeyboardButtonType.one,
        NumericKeyboardButtonType.two,
        NumericKeyboardButtonType.three,
        NumericKeyboardButtonType.empty
      ]),
      _getNumericButtonRows([
        NumericKeyboardButtonType.empty,
        NumericKeyboardButtonType.zero,
        NumericKeyboardButtonType.point,
        NumericKeyboardButtonType.done
      ])
    ]);
    return numerics;
  }

  Row _getNumericButtonRows(List<NumericKeyboardButtonType> titles) {
    var buttons = titles.map((type) {
      switch (type) {
        case NumericKeyboardButtonType.empty:
          return Expanded(child: _getEmptyButton());
        case NumericKeyboardButtonType.done:
          return Expanded(child: _getDoneButton());
        case NumericKeyboardButtonType.delete:
          return Expanded(child: _getDeleteButton());
        default:
          return Expanded(child: _getNumericButton(type));
      }
    }).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: buttons,
    );
  }

  Widget _getNumericButton(NumericKeyboardButtonType type) {
    var button = NumericButton(
        title: type.value,
        callback: () {
          _buttonHandler(type);
        });
    return button;
  }

  IconButton _getDeleteButton() {
    return IconButton(
        onPressed: () {
          _buttonHandler(NumericKeyboardButtonType.delete);
        },
        icon: Icon(Icons.arrow_back));
  }

  IconButton _getDoneButton() {
    return IconButton(
        onPressed: () {
          _buttonHandler(NumericKeyboardButtonType.done);
        },
        icon: Icon(Icons.done),
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Colors.greenAccent[400])));
  }

  TextButton _getEmptyButton() {
    return const TextButton(onPressed: null, child: Text(""));
  }

  void _buttonHandler(NumericKeyboardButtonType type) {
    setState(() {
      var newAmount = amountStringUpdator.update(amountLabel.data, type);
      var newLabel = _getAmountLabel(newAmount);
      amountLabel = newLabel;
    });
  }

  Text _getAmountLabel(String title) {
    var a = "57,";
    return Text(
      title,
      style: TextStyle(fontSize: 50),
    );
  }
}
