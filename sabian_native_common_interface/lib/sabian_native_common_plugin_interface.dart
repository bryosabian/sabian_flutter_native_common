library sabian_native_common_plugin_interface;

import 'package:sabian_native_common_plugin_interface/device/sabian_native_common_device_platform.dart';
import 'package:sabian_native_common_plugin_interface/media/sabian_native_common_media_platform.dart';
import 'package:sabian_native_common_plugin_interface/notifications/sabian_native_common_notification_platform.dart';
import 'package:sabian_native_common_plugin_interface/sabian_native_common_platform_interface.dart';

class SabianNativeCommonPlatform implements SabianNativeCommonPlatformInterface {
  @override
  SabianNativeCommonMediaPlatform media =
      SabianNativeCommonMediaPlatform.instance;

  @override
  SabianNativeCommonNotificationPlatform notification =
      SabianNativeCommonNotificationPlatform.instance;

  @override
  SabianNativeCommonDevicePlatform device =
      SabianNativeCommonDevicePlatform.instance;
}
