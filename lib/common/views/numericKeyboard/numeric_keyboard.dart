import 'package:expenso/common/views/date_time_picker.dart';
import 'package:expenso/common/views/done_button.dart';
import 'package:expenso/common/views/numericKeyboard/numeric_button.dart';
import 'package:expenso/extensions/amount_converter.dart';
import 'package:expenso/extensions/date_time.dart';
import 'package:expenso/modules/main/cubits/keyboard/amount_string_updater.dart';
import 'package:expenso/theme/theme_extensions/additional_colors.dart';
import 'package:flutter/material.dart';

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

class SizedNumericKeyboard {
  static Widget sizedKeyboard({
    required BuildContext context,
    required String amount,
    DateTime? dateTime,
    required Function(String amount, DateTime? dateTime) doneButtonCallback,
  }) {
    var keyboard = _NumericKeyboard(
      amount: amount,
      dateTime: dateTime,
      doneButtonCallback: doneButtonCallback,
    );
    return keyboard;
  }
}

// ignore: must_be_immutable
class _NumericKeyboard extends StatefulWidget {
  String amount;
  DateTime? dateTime;
  final Function(String amount, DateTime? dateTime) doneButtonCallback;

  _NumericKeyboard({
    Key? key,
    required this.amount,
    required this.dateTime,
    required this.doneButtonCallback,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NumericKeyboardState();
}

class _NumericKeyboardState extends State<_NumericKeyboard> {
  final _amountUpdater = AmountStringUpdater();
  bool get isDoneButtonDisabled => widget.amount.toIntAmount() == 0;

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
        : () => widget.doneButtonCallback(widget.amount, widget.dateTime);

    var doneButton = DoneButton(onPressed: doneButtonHandler);

    var divider = Divider(
      height: 1,
      color: Theme.of(context).extension<AdditionalColors>()!.keyboard,
    );

    var keyboardChildren = widget.dateTime == null
        ? [
            _getKeyboardHeader(context),
            divider,
            _getNumericKeyboard(context),
          ]
        : [
            _getKeyboardHeader(context),
            divider,
            const Spacer(),
            _getNumericKeyboard(context),
            const Spacer(),
          ];
    var keyboard = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: keyboardChildren,
    );
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
    } else {
      children.insert(0, const Spacer());
    }

    Row header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    );
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 32);
    return Container(
      padding: padding,
      height: MediaQuery.of(context).size.height *
          _NumericKeyboardRatios.keyboardHeader,
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
        icon: const Icon(
          Icons.arrow_back,
          size: 40,
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
    var style = Theme.of(context).textTheme.displayMedium;
    return Text(title, style: style);
  }

  Widget _getDateTimeLabel(DateTime dateTime) {
    var dateTitle = dateTime.formattedDate.toString();
    var timeTitle = dateTime.formattedTime.toString();

    var textTheme = Theme.of(context).textTheme;

    var dateStyle = textTheme.titleLarge;
    var timeStyle = textTheme.titleMedium;

    var dateText = Text(dateTitle, style: dateStyle);
    var timeText = Text(timeTitle, style: timeStyle);
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
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

class _NumericKeyboardRatios {
  static var keyboardHeader = 0.1;
}
