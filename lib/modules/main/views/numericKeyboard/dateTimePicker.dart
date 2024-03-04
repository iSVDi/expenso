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
  final double _screenHeightRatio = 0.2;

  @override
  Widget build(BuildContext context) {
    //TODO: move text to special class
    var cancelButton = TextButton(
        onPressed: () {
          widget.callback(null);
        },
        child: Text("Cancel"));
    var applyButton = TextButton(
        onPressed: () {
          widget.callback(widget._selectedDate);
        },
        child: Text("Apply")); //TODO: move text to special class

    return AlertDialog(
      content: SizedBox(
          height: MediaQuery.of(context).size.height * _screenHeightRatio,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            _getDatePicker(),
            _getTimePicker(),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [cancelButton, applyButton])
          ])),
    );
  }

//? why non-void func work without any return in body?
  Future _handleSelectedDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        //TODO which range of date?
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
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

  Widget _getDatePicker() {
    return TextButton(
        onPressed: () {
          _handleSelectedDate(context);
        },
        child: Text(widget._selectedDate.formattedDate));
  }

  Widget _getTimePicker() {
    return TextButton(
        onPressed: () {
          _handleSelectedTime(context);
        },
        child: Text(widget._selectedDate.formattedTime));
  }
}
