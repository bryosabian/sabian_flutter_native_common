import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'sabian_native_common_method_channel.dart';

abstract class SabianNativeCommonPlatform extends PlatformInterface {
  /// Constructs a SabianNativeCommonPlatform.
  SabianNativeCommonPlatform() : super(token: _token);

  static final Object _token = Object();

  static SabianNativeCommonPlatform _instance = MethodChannelSabianNativeCommon();

  /// The default instance of [SabianNativeCommonPlatform] to use.
  ///
  /// Defaults to [MethodChannelSabianNativeCommon].
  static SabianNativeCommonPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SabianNativeCommonPlatform] when
  /// they register themselves.
  static set instance(SabianNativeCommonPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
