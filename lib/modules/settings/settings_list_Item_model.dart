import 'package:flutter/widgets.dart';

class SettingsListItemModel {
  final Widget child;
  final Function()? onTap;

  SettingsListItemModel({
    required this.child,
    required this.onTap,
  });
}
