import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class SabianAbstractPlatform extends PlatformInterface {
  static final Object _token = Object();

  SabianAbstractPlatform() : super(token: _token);
}
