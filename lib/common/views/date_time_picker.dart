import 'package:expenso/common/views/rounded_button.dart';
import "package:flutter/material.dart";

import 'package:expenso/extensions/app_colors.dart';
import 'package:expenso/extensions/date_time.dart';

// ignore: must_be_immutable
class DateTimePicker extends StatefulWidget {
  late DateTime selectedDate;
  final Function(DateTime?) callback;

  DateTimePicker({
    Key? key,
    required this.selectedDate,
    required this.callback,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  final double _screenHeightRatio = 0.3;
  final double _screenWidthRatio = 0.9;

  @override
  Widget build(BuildContext context) {
    var cancelButton = RoundedButton(
        text: "cancel", //TODO: move text to special class
        textColor: AppColors.appGreen,
        borderSide: const BorderSide(color: AppColors.appGreen),
        onPressed: () => widget.callback(null));

    var applyButton = RoundedButton(
      text: "apply", //TODO: move text to special class
      textColor: AppColors.appWhite,
      backgroundColor: AppColors.appGreen,
      onPressed: () => widget.callback(widget.selectedDate),
    );

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
      surfaceTintColor: AppColors.appWhite,
      content: sizedBox,
    );
  }

  //TODO change background color
  Future _handleSelectedDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime.now(),
        initialDate: widget.selectedDate);

    if (selected != null) {
      setState(() {
        widget.selectedDate = widget.selectedDate.fromDateTime(selected);
      });
    }
  }

//TODO change background color
  Future _handleSelectedTime(BuildContext context) async {
    final TimeOfDay? selected =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (selected != null) {
      setState(() {
        widget.selectedDate = widget.selectedDate.updateTime(selected);
      });
    }
  }

  Widget _getDatePickerButton() {
    return TextButton(
        onPressed: () {
          _handleSelectedDate(context);
        },
        child: Text(widget.selectedDate.formattedDate,
        //TODO use textTheme
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
        child: Text(widget.selectedDate.formattedTime,
            //TODO use textTheme
            style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w300,
                color: AppColors.appGreen)));
  }
}
