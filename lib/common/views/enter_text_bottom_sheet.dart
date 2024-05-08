import 'package:expenso/common/views/done_button.dart';
import 'package:expenso/theme/theme_extensions/additional_colors.dart';
import "package:flutter/material.dart";

class EnterTextBottomSheet extends StatefulWidget {
  final String? text;
  final String hintText;
  final bool isPresentedModally;
  final double bottomInsets;
  final Function(String) callback;

  const EnterTextBottomSheet({
    Key? key,
    this.text,
    required this.hintText,
    this.isPresentedModally = true,
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
    var onPressed = _controller.text.isNotEmpty ? _doneButtonHandler : null;
    var button = DoneButton(isLargeButton: false, onPressed: onPressed);
    var decoration = InputDecoration(
      hintText: widget.hintText,
      border: InputBorder.none,
      fillColor: Theme.of(context).extension<AdditionalColors>()!.background1,
      filled: true,
    );
    var textField = TextField(
      decoration: decoration,
      controller: _controller,
      onSubmitted: (String value) async => _doneButtonHandler(),
      onChanged: (_) => setState(() {}),
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
    _controller.text = "";
    if (widget.isPresentedModally) {
      Navigator.pop(context);
    }
  }
}
