import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'sabian_native_common_platform_interface.dart';

/// An implementation of [SabianNativeCommonPlatform] that uses method channels.
class MethodChannelSabianNativeCommon extends SabianNativeCommonPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('sabian_native_common');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
