
import 'package:flutter/material.dart';

@immutable
class SabianThemeColors extends ThemeExtension<SabianThemeColors> {

  final Color? textColor;

  final Color? textSubColor;

  final Color? navBarColor;

  final Color? onNavBarColor;

  final Color? ratingActiveColor;

  final Color? ratingInActiveColor;

  const SabianThemeColors(
      {required this.textColor,
      required this.textSubColor,
      required this.navBarColor,
      required this.onNavBarColor,
      this.ratingActiveColor,
      this.ratingInActiveColor});

  @override
  SabianThemeColors copyWith(
      {Color? textColor,
      Color? textSubColor,
      Color? navBarColor,
      Color? onNavBarColor,
      Color? ratingActiveColor,
      Color? ratingInActiveColor}) {
    return SabianThemeColors(
        textColor: textColor ?? this.textColor,
        textSubColor: textSubColor ?? this.textSubColor,
        navBarColor: navBarColor ?? this.navBarColor,
        onNavBarColor: onNavBarColor ?? this.onNavBarColor,
        ratingActiveColor: ratingActiveColor ?? this.ratingActiveColor,
        ratingInActiveColor: ratingInActiveColor ?? this.ratingInActiveColor);
  }

  @override
  SabianThemeColors lerp(SabianThemeColors? other, double t) {
    if (other is! SabianThemeColors) {
      return this;
    }
    return SabianThemeColors(
        textColor: Color.lerp(textColor, other.textColor, t),
        textSubColor: Color.lerp(textSubColor, other.textSubColor, t),
        navBarColor: Color.lerp(navBarColor, other.navBarColor, t),
        onNavBarColor: Color.lerp(onNavBarColor, other.onNavBarColor, t),
        ratingActiveColor:
            Color.lerp(ratingActiveColor, other.ratingActiveColor, t),
        ratingInActiveColor:
            Color.lerp(ratingInActiveColor, other.ratingInActiveColor, t));
  }

  @override
  String toString() {
    return 'SabianThemeColors{textColor: $textColor, textSubColor: $textSubColor, ratingActiveColor: $ratingActiveColor, ratingInActiveColor: $ratingInActiveColor}';
  }
}
