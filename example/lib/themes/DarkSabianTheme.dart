import 'package:flutter/material.dart';
import 'package:sabian_native_common_example/themes/colors/SabianColors.dart';
import 'package:sabian_native_common_example/themes/colors/SabianThemeColors.dart';
import 'package:sabian_tools/themes/SabianThemeExtension.dart';

import 'ISabianTheme.dart';
import 'SabianColorScheme.dart';

class DarkSabianTheme implements ISabianTheme {
  static const Color _surfaceColor = Color(0xFF262626);
  static const Color _shadowSurfaceColor = Color(0xFF404040);

  @override
  String get id => "dark";

  @override
  ThemeData get theme => ThemeData(
              primarySwatch: Colors.deepPurple,
              disabledColor: Colors.white54,
              shadowColor: _shadowSurfaceColor.withOpacity(0.6),
              progressIndicatorTheme:
                  const ProgressIndicatorThemeData(color: Colors.white70),
              colorScheme: const SabianColorScheme(
                  brightness: Brightness.dark,
                  textColor: Colors.white70,
                  textSubColor: Colors.white60,
                  primary: Colors.deepPurple,
                  onPrimary: Colors.white70,
                  secondary: Colors.deepPurple,
                  onSecondary: Colors.white,
                  error: Colors.redAccent,
                  onError: Colors.white,
                  background: Colors.black54,
                  onBackground: Colors.white60,
                  surface: _surfaceColor,
                  onSurface: Color.fromARGB(180, 255, 255, 255),
                  ratingActiveColor: SabianColors.yellow_trans_50,
                  ratingInActiveColor: SabianColors.rating_disable_grey_50))
          .copyWith(
        extensions: <ThemeExtension<dynamic>>[
          const SabianThemeColors(
              textColor: Colors.white70,
              textSubColor: Colors.white54,
              navBarColor: Color(0xFF262626),
              onNavBarColor: Colors.deepPurple,
              ratingActiveColor: SabianColors.yellow_trans_50,
              ratingInActiveColor: SabianColors.rating_disable_grey_50),
          const SabianThemeExtension(
              dialogBackgroundColor: _surfaceColor,
              dialogTextColor: Colors.white60,
              dialogTitleColor: Colors.white60,
              dialogButtonColor: Colors.deepPurple,
              notificationInfoColor: Colors.blue,
              notificationErrorColor: Colors.red,
              notificationDangerColor: Colors.orange,
              notificationSuccessColor: Colors.green,
              onNotificationDangerColor: Colors.white,
              onNotificationErrorColor: Colors.white,
              onNotificationInfoColor: Colors.white,
              onNotificationSuccessColor: Colors.white
          )
        ],
      );
}
