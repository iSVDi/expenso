// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AdditionalColors extends ThemeExtension<AdditionalColors> {
  const AdditionalColors({
    required this.dotInactiveColor,
    required this.historyBarBackground,
  });

  final Color dotInactiveColor;
  final Color historyBarBackground;

  @override
  ThemeExtension<AdditionalColors> copyWith({
    Color? background1,
    Color? dotInactiveColor,
    Color? historyBarBackground,
  }) {
    return AdditionalColors(
      dotInactiveColor: dotInactiveColor ?? this.dotInactiveColor,
      historyBarBackground: historyBarBackground ?? this.historyBarBackground,
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
      historyBarBackground:
          Color.lerp(historyBarBackground, other.historyBarBackground, t) ??
              historyBarBackground,
    );
  }
}
