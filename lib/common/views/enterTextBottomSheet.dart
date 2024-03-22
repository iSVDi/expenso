import "package:flutter/material.dart";

//TODO! fix keyboard is over text field
//TODO! fix different behaviour when accept create new category via keyboard done button and custom done buttom
//? maybe decision is in keyboard presenting/hiding
class EnterTextBottomSheet extends StatefulWidget {
  String hintText;
  Function(String) callback;
  EnterTextBottomSheet({
    Key? key,
    required this.hintText,
    required this.callback,
  }) : super(key: key);

  @override
  State<EnterTextBottomSheet> createState() => _EnterTextBottomSheetState();
}

class _EnterTextBottomSheetState extends State<EnterTextBottomSheet> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var button = IconButton(
        onPressed: () {
          _doneButtonHandler();
        },
        icon: Icon(Icons.done));
    var textField = TextField(
      decoration: InputDecoration(hintText: widget.hintText),
      controller: _controller,
      onSubmitted: (String value) async {
        _doneButtonHandler();
      },
    );
    var row = Row(children: [Expanded(child: textField), button]);
    return row;
  }

  void _doneButtonHandler() {
    widget.callback(_controller.text);
    Navigator.pop(context);
  }
}