import 'package:flutter/material.dart';

class SabianColorScheme extends ColorScheme {
  final Color ratingActiveColor;
  final Color ratingInActiveColor;
  final Color textColor;
  final Color textSubColor;

  const SabianColorScheme(
      {required Brightness brightness,
      required this.textColor,
      required this.textSubColor,
      required Color primary,
      required Color onPrimary,
      required Color secondary,
      required Color onSecondary,
      required Color error,
      required Color onError,
      required Color background,
      required Color onBackground,
      required Color surface,
      required Color onSurface,
      required this.ratingActiveColor,
      required this.ratingInActiveColor})
      : super(
            brightness: brightness,
            primary: primary,
            onPrimary: onPrimary,
            secondary: secondary,
            onSecondary: onSecondary,
            error: error,
            onError: onError,
            background: background,
            onBackground: onBackground,
            surface: surface,
            onSurface: onSurface);
}
