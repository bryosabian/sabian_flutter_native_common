import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:sabian_native_common_plugin_interface/events/error/sabian_native_common_error_event_channel.dart';
import 'package:sabian_native_common_plugin_interface/events/loader/sabian_native_common_loader_event_platform.dart';

class SabianNativeCommonErrorEventPlatform
    extends SabianNativeCommonLoaderEventPlatform {
  static final Object _token = Object();

  static SabianNativeCommonErrorEventPlatform? _instance;

  /// The default instance of [SabianNativeCommonLoaderEventPlatform] to use.
  ///
  /// Defaults to [ SabianNativeCommonErrorEventChannel].
  static SabianNativeCommonErrorEventPlatform get instance =>
      _instance ?? SabianNativeCommonErrorEventChannel();

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SabianNativeCommonLoaderEventPlatform] when
  /// they register themselves.
  static set instance(SabianNativeCommonErrorEventPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  SabianNativeCommonErrorEventPlatform(super.channel);
}
