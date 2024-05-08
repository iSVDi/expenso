/*
var viewItem = FocusedMenuItem(
        backgroundColor:
            Theme.of(context).extension<AdditionalColors>()!.background1,
        title: Text(localization.view),
        onPressed: () => _presentTransaction(context, transaction));
*/

import 'package:expenso/theme/theme_extensions/additional_colors.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';

class CommonFocusedMenuItem extends FocusedMenuItem {
  CommonFocusedMenuItem(
      {required BuildContext context,
      required super.title,
      required super.onPressed}) {
    backgroundColor =
        Theme.of(context).extension<AdditionalColors>()!.background1;
  }
}
