import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:sabian_native_common_plugin_interface/common/sabian_abstract_platform.dart';
import 'package:sabian_native_common_plugin_interface/events/sabian_with_events.dart';
import 'package:sabian_native_common_plugin_interface/media/sabian_native_common_media_method_channel.dart';
import 'package:sabian_native_common_plugin_interface/structures/sabian_photo_config.dart';

import '../structures/sabian_media_response_payload.dart';

class SabianNativeCommonMediaPlatform extends SabianAbstractPlatform
    with SabianWithEventsMixIn {

  static final Object _token = Object();

  static SabianNativeCommonMediaPlatform? _instance;

  /// The default instance of [SabianNativeCommonMediaPlatform] to use.
  ///
  /// Defaults to [SabianNativeCommonMediaMethodChannel].
  static SabianNativeCommonMediaPlatform get instance =>
      _instance ??
      SabianNativeCommonMediaMethodChannel(); //New instance to avoid dangling of objects

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SabianNativeCommonMediaPlatform] when
  /// they register themselves.
  static set instance(SabianNativeCommonMediaPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<SabianMediaResponsePayload> takePicture([PhotoConfig? config]) {
    throw UnimplementedError('takePicture() has not been implemented.');
  }

  Future<SabianMediaResponsePayload> choosePicture([PhotoConfig? config]) {
    throw UnimplementedError('choosePicture() has not been implemented.');
  }
}
