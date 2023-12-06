import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:sabian_native_common_plugin_interface/events/loader/sabian_native_common_loader_event_platform.dart';
import 'package:sabian_native_common_plugin_interface/structures/sabian_progress.dart';

class SabianNativeCommonLoaderEventChannel
    extends SabianNativeCommonLoaderEventPlatform {
  static final Object _token = Object();

  static const _CHANNEL = 'com.sabian_common_native.events.loader';

  static SabianNativeCommonLoaderEventPlatform _instance =
      SabianNativeCommonLoaderEventChannel();

  /// The default instance of [SabianNativeCommonLoaderEventPlatform] to use.
  ///
  /// Defaults to [ SabianNativeCommonLoaderEventChannel].
  static SabianNativeCommonLoaderEventPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SabianNativeCommonLoaderEventPlatform] when
  /// they register themselves.
  static set instance(SabianNativeCommonLoaderEventPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  SabianNativeCommonLoaderEventChannel([String channel = _CHANNEL])
      : super(channel);

  @override
  void onEvent(dynamic payload) {
    final res = Map<String, dynamic>.from(payload);
    final progress = SabianProgress.fromParams(res);

    if (progress.isHidden == true) {
      if (onHide != null) {
        onHide!(progress);
      }
    } else {
      if (onShow != null) {
        onShow!(progress);
      }
    }
  }
}
