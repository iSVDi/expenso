import 'package:expenso/extensions/dateTime.dart';
import 'package:flutter/material.dart';
import "numericButton.dart";
import 'dateTimePicker.dart';
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

  const OnScreenNumericKeyboard({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OnScreenNumericKeyboard();
}

class _OnScreenNumericKeyboard extends State<OnScreenNumericKeyboard> {
  late Text amountLabel = _getAmountLabel("0");
  final AmountStringUpdater amountStringUpdator = AmountStringUpdater();
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[100],
      height: widget.size.height,
      width: widget.size.width,
      child: _getKeyboard(),
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

  Future _handleNewDateTime() async {
    showDialog(
        context: context,
        builder: (BuildContext context) => DateTimePicker(
              selectedDate: date,
              callback: (date) {
                if (date != null) {
                  setState(() {
                    this.date = date;
                  });
                }
                Navigator.pop(context);
              },
            ));
  }

  Widget _getKeyboardHeader() {
    var datePickerButton = TextButton(
        onPressed: () {
          _handleNewDateTime();
        },
        child: Text("${date.formattedDate}\n${date.formattedTime}",
            style: TextStyle(color: Colors.greenAccent[400], fontSize: 18)));

    var header = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [datePickerButton, amountLabel]);
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
        icon: const Icon(Icons.arrow_back));
  }

  IconButton _getDoneButton() {
    return IconButton(
        onPressed: () {
          _buttonHandler(NumericKeyboardButtonType.done);
        },
        icon: const Icon(Icons.done),
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
    return Text(
      title,
      style: const TextStyle(fontSize: 50),
    );
  }
}
