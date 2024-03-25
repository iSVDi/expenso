// ignore_for_file: public_member_api_docs, sort_constructors_first
import "package:expenso/extensions/appColors.dart";
import "package:flutter/material.dart";

import "package:expenso/extensions/dateTime.dart";

class DateTimePicker extends StatefulWidget {
  DateTime _selectedDate;
  Function(DateTime?) callback;

  DateTimePicker({
    Key? key,
    required DateTime selectedDate,
    required this.callback,
  })  : _selectedDate = selectedDate,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  final double _screenHeightRatio = 0.3;
  final double _screenWidthRatio = 0.9;

  @override
  Widget build(BuildContext context) {
    var cancelButton = _getRoundedButton(() {
      widget.callback(null);
    }, "cancel", AppColors.appGreen, //TODO: move text to special class
        borderSide: const BorderSide(color: AppColors.appGreen));

    var applyButton = _getRoundedButton(() {
      widget.callback(widget._selectedDate);
    }, "apply", AppColors.appWhite,
        backgroundColor: AppColors.appGreen); //TODO: move text to special class

    var column = Column(
        mainAxisAlignment: MainAxisAlignment.start, 
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getDatePickerButton(),
          _getTimePickerButton(),
          const SizedBox(height: 20),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [cancelButton, applyButton])
        ]);

    var sizedBox = SizedBox(
        height: MediaQuery.of(context).size.height * _screenHeightRatio,
        width: MediaQuery.of(context).size.width * _screenWidthRatio,
        child: column);
    return AlertDialog(
      content: sizedBox,
      backgroundColor: AppColors.appWhite,
    );
  }

  Future _handleSelectedDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime.now(),
        initialDate: widget._selectedDate);

    if (selected != null) {
      setState(() {
        widget._selectedDate = widget._selectedDate.fromDateTime(selected);
      });
    }
  }

  Future _handleSelectedTime(BuildContext context) async {
    final TimeOfDay? selected =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (selected != null) {
      setState(() {
        widget._selectedDate = widget._selectedDate.updateTime(selected);
      });
    }
  }

  Widget _getDatePickerButton() {
    return TextButton(
        onPressed: () {
          _handleSelectedDate(context);
        },
        child: Text(widget._selectedDate.formattedDate,
            style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w400,
                color: AppColors.appGreen)));
  }

  Widget _getTimePickerButton() {
    return TextButton(
        onPressed: () {
          _handleSelectedTime(context);
        },
        child: Text(widget._selectedDate.formattedTime,
            style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w300,
                color: AppColors.appGreen)));
  }

  ElevatedButton _getRoundedButton(
      Function() onPressed, String text, Color textColor,
      {BorderSide borderSide = BorderSide.none,
      Color backgroundColor = AppColors.appWhite}) {
    var buttonStyle = ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(backgroundColor),
        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), side: borderSide)));
    var textStyle =
        TextStyle(fontWeight: FontWeight.w300, fontSize: 24, color: textColor);

    double horizontalPadding = 5;
    double verticalPadding = 12;
    var button = ElevatedButton(
        onPressed: onPressed,
        style: buttonStyle,
        child: Padding(
          padding: EdgeInsets.fromLTRB(horizontalPadding, verticalPadding,
              horizontalPadding, verticalPadding),
          child: Text(text, //TODO: move text to special class
              style: textStyle),
        ));
    return button;
  }
}
