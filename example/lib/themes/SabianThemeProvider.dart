import 'package:flutter/material.dart';
import 'package:sabian_native_common_example/themes/colors/SabianThemeColors.dart';

class SabianTheme {

  late ThemeData theme;

  late SabianThemeColors custom;

  late ColorScheme colorScheme;

  SabianTheme.of(BuildContext context) {
    theme = Theme.of(context);
    colorScheme = theme.colorScheme;
    custom = theme.extension<SabianThemeColors>()!;
  }

  factory SabianTheme.instance(BuildContext context) {
    return SabianTheme.of(context);
  }
}
