// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:expenso/extensions/app_colors.dart';

class DoneButton extends StatefulWidget {
  bool isLargeButton;
  Function()? onPressed;

  DoneButton({
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
    var buttonColor = widget.onPressed == null
        ? AppColors.appDisabledGreen
        : AppColors.appGreen;

    var icon = const Icon(
      Icons.done_sharp,
      color: AppColors.appWhite,
    );

    var ratio = widget.isLargeButton ? 0.235 : 0.106;
    var sideSize = MediaQuery.of(context).size.width * ratio;
    var buttonStyleSize = Size(sideSize, sideSize);

    var buttonStyle = ButtonStyle(
        minimumSize: MaterialStatePropertyAll(buttonStyleSize),
        backgroundColor: MaterialStateProperty.all(buttonColor));

    var button = IconButton(
        color: AppColors.appGreen,
        disabledColor: AppColors.appDisabledGreen,
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
