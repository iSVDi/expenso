// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DoneButton extends StatefulWidget {
  final bool isLargeButton;
  final Function()? onPressed;

  const DoneButton({
    Key? key,
    this.isLargeButton = true,
    this.onPressed,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DoneButtonState();
}

class _DoneButtonState extends State<DoneButton> {
  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var buttonColor =
        widget.onPressed == null ? colorScheme.onPrimary : colorScheme.primary;

    var icon = const Icon(
      Icons.done_sharp,
      color: Colors.white,
    );

    var ratio = widget.isLargeButton ? 0.235 : 0.106;
    var sideSize = MediaQuery.of(context).size.width * ratio;
    var buttonStyleSize = Size(sideSize, sideSize);

    var buttonStyle = ButtonStyle(
        minimumSize: MaterialStatePropertyAll(buttonStyleSize),
        backgroundColor: MaterialStateProperty.all(buttonColor));

    var button = IconButton(
        color: colorScheme.primary,
        disabledColor: colorScheme.onPrimary,
        onPressed: widget.onPressed,
        icon: icon,
        iconSize: widget.isLargeButton ? 40 : 24,
        style: buttonStyle);

    if (!widget.isLargeButton) {
      return button;
    }
    return Padding(
      padding: const EdgeInsets.only(right: 5, bottom: 5),
      child: button,
    );
  }
}
