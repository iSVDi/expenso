import "package:flutter/material.dart";

//TODO! fix keyboard is over text field
//TODO! fix different behaviour when accept create new category via keyboard done button and custom done buttom
// TODO save comment when user tap outside of sheet and its begin closing
//? maybe decision is in keyboard presenting/hiding
class EnterTextBottomSheet extends StatefulWidget {
  final String? text;
  final String hintText;
  final Function(String) callback;

  const EnterTextBottomSheet({
    Key? key,
    this.text,
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
    _controller = TextEditingController(text: widget.text);
  }

  @override
  Widget build(BuildContext context) {
    var button = IconButton(
        onPressed: () {
          _doneButtonHandler();
        },
        icon: const Icon(Icons.done));
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
