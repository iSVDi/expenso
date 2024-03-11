import "package:flutter/material.dart";

//TODO! fix keyboard is over text field
class EnterCategoryTextField extends StatefulWidget {
  Function(String) callback;
  EnterCategoryTextField({
    Key? key,
    required this.callback,
  }) : super(key: key);

  @override
  State<EnterCategoryTextField> createState() => _EnterCategoryTextFieldState();
}

class _EnterCategoryTextFieldState extends State<EnterCategoryTextField> {
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
      //todo get text from special class
      decoration: InputDecoration(hintText: "enter category name"),
      controller: _controller,
      onSubmitted: (String value) async {
        _doneButtonHandler();
      },
    );
    var row = Row(children: [Expanded(child: textField), button]);
    return row;
  }

  void _doneButtonHandler() {
    if (_controller.text.isEmpty) {
      return;
    }
    widget.callback(_controller.text);
    Navigator.pop(context);
  }
}
