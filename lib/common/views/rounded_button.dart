// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final BorderSide borderSide;
  final Function() onPressed;

  const RoundedButton({
    Key? key,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    this.borderSide = BorderSide.none,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var buttonShape = MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: borderSide,
      ),
    );
    var buttonStyle = ButtonStyle(
        surfaceTintColor: MaterialStatePropertyAll(backgroundColor),
        backgroundColor: MaterialStatePropertyAll(backgroundColor),
        shape: buttonShape);

    var textStyle = Theme.of(context)
        .textTheme
        .headlineSmall
        ?.copyWith(color: textColor, fontWeight: FontWeight.w300);

    double horizontalPadding = 5;
    double verticalPadding = 12;
    var child = Padding(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        child: Text(text, style: textStyle));
    var button =
        ElevatedButton(onPressed: onPressed, style: buttonStyle, child: child);
    return button;
  }

  static RoundedButton getCancelButton({
    required BuildContext context,
    required Function() onPressed,
  }) {
    var colorScheme = Theme.of(context).colorScheme;
    var cancelButton = RoundedButton(
        text: AppLocalizations.of(context)!.cancel,
        textColor: colorScheme.primary,
        backgroundColor: colorScheme.background,
        borderSide: BorderSide(color: colorScheme.primary),
        onPressed: onPressed);
    return cancelButton;
  }

  static RoundedButton getActionButton({
    required BuildContext context,
    required String text,
    required Function() onPressed,
  }) {
    var colorScheme = Theme.of(context).colorScheme;
    var cancelButton = RoundedButton(
        text: text,
        textColor: colorScheme.background,
        backgroundColor: colorScheme.primary,
        borderSide: BorderSide(color: colorScheme.primary),
        onPressed: onPressed);
    return cancelButton;
  }
}
