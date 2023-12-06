import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sabian_native_common_plugin_interface/notifications/sabian_native_common_notification_platform.dart';
import 'package:sabian_native_common_plugin_interface/structures/sabian_common_native_error.dart';
import 'package:sabian_native_common_plugin_interface/structures/sabian_notification_config.dart';
import 'package:sabian_native_common_plugin_interface/structures/sabian_response_payload.dart';

class SabianNativeCommonNotificationMethodChannel
    extends SabianNativeCommonNotificationPlatform {

  @visibleForTesting
  final methodChannel =
      const MethodChannel('com.sabian_common_native.methods.notifications');

  @override
  Future<SabianResponsePayload> notify(NotificationConfig config) async {
    final params = <String, String>{"notificationConfig": config.toJson()};
    try {
      final response =
          await methodChannel.invokeMethod("postNotification", params);
      final payload = Map<String, dynamic>.from(response);
      final message = payload["status"] as String;
      return SabianResponsePayload(message);
    } on PlatformException catch (pe) {
      return Future.error(pe.toNativeError);
    } on Exception catch (e) {
      return Future.error(e.toNativeError);
    }
  }
}
