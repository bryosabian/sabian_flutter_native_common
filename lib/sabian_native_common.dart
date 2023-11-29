import 'package:sabian_native_common/media/sabian_native_common_media_platform.dart';
import 'package:sabian_native_common/notifications/sabian_native_common_notification_platform.dart';

import 'sabian_native_common_platform_interface.dart';

class SabianNativeCommon {
  final platform = SabianNativeCommonPlatform.instance;
  final media = SabianNativeCommonMediaPlatform.instance;
  final notification = SabianNativeCommonNotificationPlatform.instance;
}
