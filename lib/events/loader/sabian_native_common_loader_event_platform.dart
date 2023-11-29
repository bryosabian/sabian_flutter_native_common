import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:sabian_native_common/events/loader/sabian_native_common_loader_event_channel.dart';
import 'package:sabian_native_common/events/sabian_abstract_event_platform.dart';
import 'package:sabian_native_common/structures/sabian_progress.dart';

class SabianNativeCommonLoaderEventPlatform
    extends SabianAbstractEventPlatform {
  static final Object _token = Object();

  Function(SabianProgress)? onShow;

  Function(SabianProgress?)? onHide;

  static SabianNativeCommonLoaderEventPlatform? _instance;

  /// The default instance of [SabianNativeCommonLoaderEventPlatform] to use.
  ///
  /// Defaults to [ SabianNativeCommonLoaderEventChannel].
  static SabianNativeCommonLoaderEventPlatform get instance =>
      _instance ?? SabianNativeCommonLoaderEventChannel();

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SabianNativeCommonLoaderEventPlatform] when
  /// they register themselves.
  static set instance(SabianNativeCommonLoaderEventPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  SabianNativeCommonLoaderEventPlatform(super.channel);
}
