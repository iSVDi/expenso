import 'package:flutter/material.dart';

class AdditionalColors extends ThemeExtension<AdditionalColors> {
  const AdditionalColors({
    required this.background1,
    required this.dotInactiveColor,
  });

  final Color background1;
  final Color dotInactiveColor;

  @override
  ThemeExtension<AdditionalColors> copyWith({
    Color? background1,
    Color? dotInactiveColor,
  }) {
    return AdditionalColors(
      background1: background1 ?? this.background1,
      dotInactiveColor: dotInactiveColor ?? this.dotInactiveColor,
    );
  }

  @override
  ThemeExtension<AdditionalColors> lerp(
      covariant ThemeExtension<AdditionalColors>? other, double t) {
    if (other is! AdditionalColors) {
      return this;
    }
    return AdditionalColors(
      background1: Color.lerp(background1, other.background1, t) ?? background1,
      dotInactiveColor:
          Color.lerp(dotInactiveColor, other.dotInactiveColor, t) ??
              dotInactiveColor,
    );
  }
}
