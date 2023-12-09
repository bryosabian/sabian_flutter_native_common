import 'package:flutter_test/flutter_test.dart';
import 'package:sabian_native_common_ios/sabian_native_common_ios.dart';
import 'package:sabian_native_common_interface/device/sabian_native_common_device_platform.dart';

class MockSabianNativeCommonMediaPlatform
    extends SabianNativeCommonDevicePlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SabianNativeCommonIos platform = SabianNativeCommonIos();
  MockSabianNativeCommonMediaPlatform fakeMediaPlatform =
  MockSabianNativeCommonMediaPlatform();
  SabianNativeCommonDevicePlatform.instance = fakeMediaPlatform;

  test('$MockSabianNativeCommonMediaPlatform is the default instance', () {
    expect(
        platform.device, isInstanceOf<MockSabianNativeCommonMediaPlatform>());
  });

  test('getPlatformVersion', () async {
    SabianNativeCommonIos plugin =
    SabianNativeCommonIos();
    expect(await plugin.device.getPlatformVersion(),
        '42');
  });
}
