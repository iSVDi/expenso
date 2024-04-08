import 'package:expenso/my_app.dart';
import "package:flutter/material.dart";
import 'package:expenso/extensions/date_time.dart';

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

  ColorScheme _getColorScheme(BuildContext context) =>
      Theme.of(context).colorScheme;

  @override
  Widget build(BuildContext context) {
    var colorScheme = _getColorScheme(context);

    var cancelButton = _getRoundedButton(
        text: "cancel", //TODO: move text to special class
        textColor: colorScheme.primary,
        borderSide: BorderSide(color: colorScheme.primary),
        onPressed: () => widget.callback(null));

    var applyButton = _getRoundedButton(
      text: "apply", //TODO: move text to special class
      textColor: Colors.white,
      backgroundColor: colorScheme.primary,
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
      surfaceTintColor: colorScheme.background,
      content: sizedBox,
    );
  }

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
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w400,
                color: _getColorScheme(context).primary)));
  }

  Widget _getTimePickerButton() {
    return TextButton(
        onPressed: () {
          _handleSelectedTime(context);
        },
        child: Text(widget.selectedDate.formattedTime,
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w300,
                color: _getColorScheme(context).primary)));
  }

  ElevatedButton _getRoundedButton({
    required String text,
    required Color textColor,
    BorderSide borderSide = BorderSide.none,
    Color backgroundColor = Colors.white,
    required Function() onPressed,
  }) {
    var buttonStyle = ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(backgroundColor),
        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), side: borderSide)));

    var textStyle =
        Theme.of(context).textTheme.appTitle3.copyWith(color: textColor);

    double horizontalPadding = 5;
    double verticalPadding = 12;
    var child = Padding(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        child: Text(text, style: textStyle));
    var button =
        ElevatedButton(onPressed: onPressed, style: buttonStyle, child: child);
    return button;
  }
}
