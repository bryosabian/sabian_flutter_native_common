import 'package:sabian_native_common_plugin_interface/common/sabian_abstract_platform.dart';
import 'package:sabian_native_common_plugin_interface/device/sabian_native_common_device_platform.dart';
import 'package:sabian_native_common_plugin_interface/media/sabian_native_common_media_platform.dart';
import 'package:sabian_native_common_plugin_interface/notifications/sabian_native_common_notification_platform.dart';

abstract class SabianNativeCommonPlatformInterface
    extends SabianAbstractPlatform {
  late SabianNativeCommonMediaPlatform media;
  late SabianNativeCommonNotificationPlatform notification;
  late SabianNativeCommonDevicePlatform device;
}
