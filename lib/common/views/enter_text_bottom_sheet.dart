import "package:flutter/material.dart";

class EnterTextBottomSheet extends StatefulWidget {
  final String? text;
  final String hintText;
  final double bottomInsets;
  final Function(String) callback;

  EnterTextBottomSheet({
    Key? key,
    this.text,
    required this.hintText,
    required this.bottomInsets,
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

    var padding = EdgeInsets.only(
      left: 32,
      right: 32,
      bottom: widget.bottomInsets,
    );

    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height * 0.123;
    var container = SizedBox(height: height, child: row);

    return Padding(padding: padding, child: container);
  }

  void _doneButtonHandler() {
    widget.callback(_controller.text);
    Navigator.pop(context);
  }
}
