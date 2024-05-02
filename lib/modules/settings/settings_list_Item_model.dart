import 'package:flutter/material.dart';

class SettingsItemModel {
  final Widget child;
  final Function()? onTap;

  SettingsItemModel({
    required this.child,
    required this.onTap,
  });
}
