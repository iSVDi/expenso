import 'package:flutter/material.dart';

class DividerColors extends ThemeExtension<DividerColors> {
  const DividerColors({
    required this.keyboard,
    required this.history,
    required this.historyFirstSection,
    required this.welcome,
  });

  final Color keyboard;
  final Color history;
  final Color historyFirstSection;
  final Color welcome;

  @override
  ThemeExtension<DividerColors> copyWith({
    Color? keyboard,
    Color? history,
    Color? historyFirstSection,
    Color? welcome,
  }) {
    return DividerColors(
      keyboard: keyboard ?? this.keyboard,
      history: history ?? this.history,
      historyFirstSection: historyFirstSection ?? this.historyFirstSection,
      welcome: welcome ?? this.welcome,
    );
  }

  @override
  ThemeExtension<DividerColors> lerp(
      covariant ThemeExtension<DividerColors>? other, double t) {
    if (other is! DividerColors) {
      return this;
    }
    return DividerColors(
      keyboard: Color.lerp(keyboard, other.keyboard, t) ?? keyboard,
      history: Color.lerp(history, other.history, t) ?? history,
      historyFirstSection:
          Color.lerp(historyFirstSection, other.historyFirstSection, t) ??
              historyFirstSection,
      welcome: Color.lerp(welcome, other.welcome, t) ?? welcome,
    );
  }
}
