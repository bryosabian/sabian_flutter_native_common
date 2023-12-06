import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:sabian_native_common_plugin_interface/common/sabian_abstract_platform.dart';
import 'package:sabian_native_common_plugin_interface/notifications/sabian_native_common_notification_method_channel.dart';
import 'package:sabian_native_common_plugin_interface/structures/sabian_notification_config.dart';
import 'package:sabian_native_common_plugin_interface/structures/sabian_response_payload.dart';

class SabianNativeCommonNotificationPlatform extends SabianAbstractPlatform {
  static final Object _token = Object();

  static SabianNativeCommonNotificationPlatform? _instance;

  /// The default instance of [SabianNativeCommonNotificationPlatform] to use.
  ///
  /// Defaults to [SabianNativeCommonNotificationMethodChannel].
  static SabianNativeCommonNotificationPlatform get instance =>
      _instance ??
      SabianNativeCommonNotificationMethodChannel(); //Avoid dangling of objects

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SabianNativeCommonNotificationPlatform] when
  /// they register themselves.
  static set instance(SabianNativeCommonNotificationPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<SabianResponsePayload> notify(NotificationConfig config) {
    throw UnimplementedError('notify() has not been implemented.');
  }
}
