import 'package:flutter_test/flutter_test.dart';
import 'package:sabian_native_common_android/sabian_native_common_android.dart';
import 'package:sabian_native_common_interface/device/sabian_native_common_device_platform.dart';

class MockSabianNativeCommonMediaPlatform
    extends SabianNativeCommonDevicePlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SabianNativeCommonAndroid platform = SabianNativeCommonAndroid();
  MockSabianNativeCommonMediaPlatform fakeMediaPlatform =
      MockSabianNativeCommonMediaPlatform();
  SabianNativeCommonDevicePlatform.instance = fakeMediaPlatform;

  test('$MockSabianNativeCommonMediaPlatform is the default instance', () {
    expect(
        platform.device, isInstanceOf<MockSabianNativeCommonMediaPlatform>());
  });

  test('getPlatformVersion', () async {
    SabianNativeCommonAndroid sabianNativeCommonAndroidPlugin =
        SabianNativeCommonAndroid();
    expect(await sabianNativeCommonAndroidPlugin.device.getPlatformVersion(),
        '42');
  });
}
