import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:sabian_native_common/sabian_native_common.dart';
import 'package:sabian_native_common/structures/sabian_notification_config.dart';
import 'package:sabian_native_common/structures/sabian_photo_config.dart';
import 'package:sabian_native_common/structures/sabian_response_payload.dart';
import 'package:sabian_native_common_example/Home.dart';
import 'package:sabian_native_common_example/themes/DarkSabianTheme.dart';
import 'package:sabian_native_common_example/themes/LightSabianTheme.dart';
import 'package:sabian_tools/controls/SabianButton.dart';
import 'package:sabian_tools/controls/SabianRobotoText.dart';
import 'package:sabian_tools/modals/progress/SabianProgressModal.dart';
import 'package:sabian_tools/toast/SabianToast.dart';
import 'package:sabian_tools/toast/SabianToastType.dart';
import 'package:sabian_tools/utils/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: LightSabianTheme().theme,
      darkTheme: DarkSabianTheme().theme,
      themeMode: ThemeMode.system,
      home: const Home(),
    );
  }
}
