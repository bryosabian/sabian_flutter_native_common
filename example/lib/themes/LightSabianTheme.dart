import 'package:flutter/material.dart';
import 'package:sabian_native_common_example/themes/colors/SabianColors.dart';
import 'package:sabian_native_common_example/themes/colors/SabianThemeColors.dart';
import 'package:sabian_tools/themes/SabianThemeExtension.dart';

import 'ISabianTheme.dart';

class LightSabianTheme implements ISabianTheme {
  static const Color _textColor = Color(0xFF5a5a5a);
  static const Color _textSubColor = Color(0xFF808182);

  @override
  String get id => "light";

  @override
  ThemeData get theme => ThemeData(
          primarySwatch: Colors.deepPurple,
          disabledColor: Colors.white54,
          shadowColor: Colors.grey.withOpacity(0.5),
          progressIndicatorTheme:
              const ProgressIndicatorThemeData(color: Colors.deepPurple),
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Colors.deepPurple,
            onPrimary: Colors.white,
            secondary: Colors.purpleAccent,
            onSecondary: Colors.white,
            error: Colors.redAccent,
            onError: Colors.white,
            background: Colors.white,
            onBackground: Colors.black,
            surface: Colors.white,
            onSurface: _textColor,
          )).copyWith(extensions: <ThemeExtension<dynamic>>[
        const SabianThemeColors(
            textColor: _textColor,
            textSubColor: _textSubColor,
            navBarColor: Colors.deepPurple,
            onNavBarColor: Colors.white,
            ratingActiveColor: SabianColors.yellow,
            ratingInActiveColor: SabianColors.rating_disable_grey),
        const SabianThemeExtension(
            dialogBackgroundColor: Colors.white,
            dialogTextColor: Colors.black,
            dialogTitleColor: Colors.black,
            dialogButtonColor: Colors.deepPurple,
            notificationInfoColor: Colors.blue,
            notificationErrorColor: Colors.red,
            notificationDangerColor: Colors.orange,
            notificationSuccessColor: Colors.green,
            onNotificationDangerColor: Colors.white,
            onNotificationErrorColor: Colors.white,
            onNotificationInfoColor: Colors.white,
            onNotificationSuccessColor: Colors.white)
      ]);
}
