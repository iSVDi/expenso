import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';

class CommonFocusedMenuItem extends FocusedMenuItem {
  CommonFocusedMenuItem(
      {required BuildContext context,
      required super.title,
      required super.onPressed})
      : super(backgroundColor: Theme.of(context).colorScheme.surfaceVariant);
}
