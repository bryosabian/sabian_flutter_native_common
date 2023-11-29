import 'package:sabian_native_common/events/error/sabian_native_common_error_event_platform.dart';

class SabianNativeCommonErrorEventChannel
    extends SabianNativeCommonErrorEventPlatform {
  static const _CHANNEL = 'com.sabian_common_native.events.error';

  SabianNativeCommonErrorEventChannel() : super(_CHANNEL);
}
