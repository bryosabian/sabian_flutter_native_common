import 'package:flutter_test/flutter_test.dart';
import 'package:sabian_native_common/sabian_native_common.dart';
import 'package:sabian_native_common_plugin_interface/device/sabian_native_common_device_platform.dart';
import 'package:sabian_native_common_plugin_interface/media/sabian_native_common_media_platform.dart';
import 'package:sabian_native_common_plugin_interface/notifications/sabian_native_common_notification_platform.dart';
import 'package:sabian_native_common_plugin_interface/structures/sabian_media_response_payload.dart';
import 'package:sabian_native_common_plugin_interface/structures/sabian_notification_config.dart';
import 'package:sabian_native_common_plugin_interface/structures/sabian_photo_config.dart';
import 'package:sabian_native_common_plugin_interface/structures/sabian_response_payload.dart';

class MockSabianNativeCommonDevicePlatform
    extends SabianNativeCommonDevicePlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

class MockSabianNativeCommonNotificationPlatform
    extends SabianNativeCommonNotificationPlatform {
  @override
  Future<SabianResponsePayload> notify(NotificationConfig config) {
    return Future.value(SabianResponsePayload("testSuccess"));
  }
}

class MockSabianNativeCommonMediaPlatform
    extends SabianNativeCommonMediaPlatform {
  @override
  Future<SabianMediaResponsePayload> takePicture([PhotoConfig? config]) {
    return Future.value(SabianMediaResponsePayload("takePictureSuccess", []));
  }

  @override
  Future<SabianMediaResponsePayload> choosePicture([PhotoConfig? config]) {
    return Future.value(SabianMediaResponsePayload("choosePictureSuccess", []));
  }
}

void main() {
  SabianNativeCommonDevicePlatform.instance =
      MockSabianNativeCommonDevicePlatform();

  SabianNativeCommonNotificationPlatform.instance =
      MockSabianNativeCommonNotificationPlatform();

  SabianNativeCommonMediaPlatform.instance =
      MockSabianNativeCommonMediaPlatform();

  final SabianNativeCommon initialPlatform = SabianNativeCommon();

  test('$MockSabianNativeCommonDevicePlatform is the default device instance',
      () {
    expect(initialPlatform.device,
        isInstanceOf<MockSabianNativeCommonDevicePlatform>());
  });

  test('getPlatformVersion', () async {
    expect(await initialPlatform.device.getPlatformVersion(), '42');
  });

  test('notification', () async {
    final payload =
        await initialPlatform.notification.notify(NotificationConfig());
    expect(payload.status, "testSuccess");
  });

  test('takePhoto', () async {
    final payload = await initialPlatform.media.takePicture();
    expect(payload.status, "takePictureSuccess");
  });

  test('choosePhoto', () async {
    final payload = await initialPlatform.media.choosePicture();
    expect(payload.status, "choosePictureSuccess");
  });
}
