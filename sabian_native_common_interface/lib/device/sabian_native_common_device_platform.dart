import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:sabian_native_common_plugin_interface/common/sabian_abstract_platform.dart';
import 'package:sabian_native_common_plugin_interface/device/sabian_native_common_device_method_channel.dart';

class SabianNativeCommonDevicePlatform extends SabianAbstractPlatform {
  static final Object _token = SabianAbstractPlatform.token;

  static SabianNativeCommonDevicePlatform? _instance;

  /// The default instance of [SabianNativeCommonDevicePlatform] to use.
  ///
  /// Defaults to [SabianNativeCommonNotificationMethodChannel].
  static SabianNativeCommonDevicePlatform get instance =>
      _instance ??
      SabianNativeCommonDeviceMethodChannel(); //Avoid dangling of objects

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SabianNativeCommonNotificationPlatform] when
  /// they register themselves.
  static set instance(SabianNativeCommonDevicePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw Exception('getPlatformVersion() not initialized');
  }
}
