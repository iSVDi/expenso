import 'package:expenso/common/views/rounded_button.dart';
import "package:flutter/material.dart";

import 'package:expenso/extensions/date_time.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

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
    var cancelButton = RoundedButton.getCancelButton(
      context: context,
      onPressed: () => widget.callback(null),
    );

    var applyButton = RoundedButton.getActionButton(
      context: context,
      text: AppLocalizations.of(context)!.apply,
      onPressed: () => widget.callback(widget.selectedDate),
    );

    var column = Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getDatePickerButton(context),
          _getTimePickerButton(context),
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
      surfaceTintColor: Theme.of(context).colorScheme.background,
      content: sizedBox,
    );
  }

  Future _handleSelectedDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime.now(),
        initialDate: widget.selectedDate);

    if (selected != null) {
      setState(() {
        widget.selectedDate = widget.selectedDate.fromDateTime(selected);
      });
    }
  }

  Future _handleSelectedTime(BuildContext context) async {
    final TimeOfDay? selected = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selected != null) {
      setState(() {
        widget.selectedDate = widget.selectedDate.updateTime(selected);
      });
    }
  }

  Widget _getDatePickerButton(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return TextButton(
        onPressed: () => _handleSelectedDate(context),
        child: Text(
          widget.selectedDate.formattedDate,
          style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w400),
        ));
  }

  Widget _getTimePickerButton(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return TextButton(
        onPressed: () => _handleSelectedTime(context),
        child: Text(
          widget.selectedDate.formattedTime,
          style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w300),
        ));
  }
}
