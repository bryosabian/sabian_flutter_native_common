import 'package:sabian_native_common/events/error/sabian_native_common_error_event_platform.dart';
import 'package:sabian_native_common/events/loader/sabian_native_common_loader_event_platform.dart';

class SabianNativeCommonEvents {
  final error = SabianNativeCommonErrorEventPlatform.instance;
  final progress = SabianNativeCommonLoaderEventPlatform.instance;
}
