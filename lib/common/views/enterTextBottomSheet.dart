import "package:flutter/material.dart";

//TODO! fix keyboard is over text field
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
  void dispose() {
    _controller.dispose();
    super.dispose();
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
