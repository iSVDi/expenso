// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AdditionalColors extends ThemeExtension<AdditionalColors> {
  const AdditionalColors({
    required this.dotInactiveColor,
    required this.keyboard,
    required this.history,
    required this.historyFirstSection,
    required this.historyBarBackground,
    required this.welcome,
  });

  final Color dotInactiveColor;
  final Color keyboard;
  final Color history;
  final Color historyBarBackground;
  final Color historyFirstSection;
  final Color welcome;

  @override
  ThemeExtension<AdditionalColors> copyWith({
    Color? dotInactiveColor,
    Color? keyboard,
    Color? history,
    Color? historyBarBackground,
    Color? historyFirstSection,
    Color? welcome,
  }) {
    return AdditionalColors(
      dotInactiveColor: dotInactiveColor ?? this.dotInactiveColor,
      keyboard: keyboard ?? this.keyboard,
      history: history ?? this.history,
      historyFirstSection: historyFirstSection ?? this.historyFirstSection,
      historyBarBackground: historyBarBackground ?? this.historyBarBackground,
      welcome: welcome ?? this.welcome,
    );
  }

  @override
  ThemeExtension<AdditionalColors> lerp(
      covariant ThemeExtension<AdditionalColors>? other, double t) {
    if (other is! AdditionalColors) {
      return this;
    }
    return AdditionalColors(
      dotInactiveColor:
          Color.lerp(dotInactiveColor, other.dotInactiveColor, t) ??
              dotInactiveColor,
      keyboard: Color.lerp(keyboard, other.keyboard, t) ?? keyboard,
      history: Color.lerp(history, other.history, t) ?? history,
      historyFirstSection:
          Color.lerp(historyFirstSection, other.historyFirstSection, t) ??
              historyFirstSection,
      historyBarBackground:
          Color.lerp(historyBarBackground, other.historyBarBackground, t) ??
              historyBarBackground,
      welcome: Color.lerp(welcome, other.welcome, t) ?? welcome,
    );
  }
}
