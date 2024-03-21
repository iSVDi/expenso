// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expenso/common/views/numericKeyboard/numericButton.dart';
import 'package:expenso/extensions/appColors.dart';
import 'package:expenso/modules/main/helpers/amountStringUpdater.dart';
import 'package:expenso/common/views/dateTimePicker.dart';
import 'package:expenso/common/views/viewFactory.dart';
import 'package:flutter/material.dart';

import 'package:expenso/extensions/dateTime.dart';

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
  delete("x");

  final String value;
  const NumericKeyboardButtonType(this.value);
}

class NumericKeyboard extends StatefulWidget {
  String amount;
  final Function(String amount, DateTime? dateTime) doneButtonCallback;
  final Function(DateTime dateTime)? dateTimeButtonCallback;
  DateTime? dateTime;

  NumericKeyboard(
      {Key? key,
      required this.amount,
      required this.doneButtonCallback,
      this.dateTimeButtonCallback,
      this.dateTime})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => NumericKeyboardState();
}

class NumericKeyboardState extends State<NumericKeyboard> {
  final _amountUpdater = AmountStringUpdater();
  bool get isDoneButtonDisabled => double.parse(widget.amount) == 0;

  @override
  Widget build(BuildContext context) {
    return _getKeyboard(context);
  }

  void updateAmount(NumericKeyboardButtonType buttonType) {
    var newValue = _amountUpdater.update(widget.amount, buttonType);
    setState(() {
      widget.amount = newValue;
    });
  }

  Widget _getKeyboard(BuildContext context) {
    var doneButtonHandler = isDoneButtonDisabled
        ? null
        : () {
            widget.doneButtonCallback(widget.amount, widget.dateTime);
          };
    var doneButton = ViewFactory.getDoneButton(context, doneButtonHandler);
    var keyboard = Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      _getKeyboardHeader(context),
      Divider(
        thickness: 1,
        color: AppColors.appBlack,
      ),
      _getNumericKeyboard(context)
    ]);
    var keyboardStack = Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [keyboard, doneButton]);

    return keyboardStack;
  }

  Widget _getKeyboardHeader(BuildContext context) {
    var date = widget.dateTime;
    List<Widget> children = [_getAmountLabel(widget.amount)];
    if (date != null) {
      var datePickerButton = TextButton(
          onPressed: () {
            _newDateTimeHandler(context);
          },
          child: _getDateTimeLabel(date));
      children.insert(0, datePickerButton);
    }

    Row header = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, children: children);
    EdgeInsets padding = const EdgeInsets.only(left: 32, right: 32);
    return Container(
      padding: padding,
      height: 74,
      child: header,
    );
  }

  Widget _getNumericKeyboard(BuildContext context) {
    var numerics = Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      _getNumericButtonRows([
        NumericKeyboardButtonType.seven,
        NumericKeyboardButtonType.eight,
        NumericKeyboardButtonType.nine,
        NumericKeyboardButtonType.delete
      ], context),
      _getNumericButtonRows([
        NumericKeyboardButtonType.four,
        NumericKeyboardButtonType.five,
        NumericKeyboardButtonType.six,
        NumericKeyboardButtonType.empty
      ], context),
      _getNumericButtonRows([
        NumericKeyboardButtonType.one,
        NumericKeyboardButtonType.two,
        NumericKeyboardButtonType.three,
        NumericKeyboardButtonType.empty
      ], context),
      _getNumericButtonRows([
        NumericKeyboardButtonType.empty,
        NumericKeyboardButtonType.zero,
        NumericKeyboardButtonType.point,
        NumericKeyboardButtonType.empty,
      ], context)
    ]);
    return numerics;
  }

  Row _getNumericButtonRows(
      List<NumericKeyboardButtonType> titles, BuildContext context) {
    var buttons = titles.map((type) {
      switch (type) {
        case NumericKeyboardButtonType.empty:
          return Expanded(child: _getEmptyButton());
        case NumericKeyboardButtonType.delete:
          return Expanded(child: _getDeleteButton(context));
        default:
          return Expanded(child: _getNumericButton(type, context));
      }
    }).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: buttons,
    );
  }

  TextButton _getEmptyButton() {
    return const TextButton(onPressed: null, child: Text(""));
  }

  IconButton _getDeleteButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          _numericButtonHandler(NumericKeyboardButtonType.delete, context);
        },
        icon: Icon(
          Icons.arrow_back,
          size: 40,
          color: AppColors.appBlack,
        ));
  }

  Widget _getNumericButton(
      NumericKeyboardButtonType type, BuildContext context) {
    var button = NumericButton(
        title: type.value,
        callback: () {
          _numericButtonHandler(type, context);
        });
    return button;
  }

  Text _getAmountLabel(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 50, fontWeight: FontWeight.w300),
    );
  }

  Widget _getDateTimeLabel(DateTime dateTime) {
    var dateTitle = dateTime.formattedDate.toString();
    var timeTitle = dateTime.formattedTime.toString();

    var dateText = Text(dateTitle,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.appGreen));
    var timeText = Text(timeTitle,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColors.appDisabledGreen));
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [dateText, timeText]);
  }

  Future _newDateTimeHandler(BuildContext context) async {
    var date = widget.dateTime;
    if (date != null) {
      showDialog(
          context: context,
          builder: (BuildContext context) => DateTimePicker(
                selectedDate: date,
                callback: (date) {
                  if (date != null) {
                    setState(() {
                      widget.dateTime = date;
                    });
                  }
                  Navigator.pop(context);
                },
              ));
    }
  }

  void _numericButtonHandler(
      NumericKeyboardButtonType type, BuildContext context) {
    setState(() {
      updateAmount(type);
    });
  }
}
