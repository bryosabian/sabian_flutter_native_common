import 'package:flutter/material.dart';
import 'package:sabian_native_common_example/Home.dart';
import 'package:sabian_native_common_example/themes/DarkSabianTheme.dart';
import 'package:sabian_native_common_example/themes/LightSabianTheme.dart';

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
