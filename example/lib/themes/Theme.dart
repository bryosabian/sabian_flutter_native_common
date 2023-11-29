import 'dart:collection';

import 'package:sabian_native_common_example/themes/DarkSabianTheme.dart';
import 'package:sabian_native_common_example/themes/ISabianTheme.dart';
import 'package:sabian_native_common_example/themes/LightSabianTheme.dart';


class Theme {

  factory Theme.instance() {
    return Theme();
  }

  Theme() {
    registerTheme("light", LightSabianTheme());
    registerTheme("dark", DarkSabianTheme());
  }

  String _current = "light";

  late HashMap<String, ISabianTheme> _themes;

  ISabianTheme get current => _themes[_current]!;

  void setCurrent(String current) => _current = current;

  void registerTheme(String id, ISabianTheme theme) => _themes[id] = theme;
}
