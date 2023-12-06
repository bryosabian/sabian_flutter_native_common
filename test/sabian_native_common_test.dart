import 'package:flutter_test/flutter_test.dart';
import 'package:sabian_native_common/sabian_native_common.dart';
import 'package:sabian_native_common_plugin_interface/device/sabian_native_common_device_platform.dart';

class MockSabianNativeCommonDevicePlatform
    implements SabianNativeCommonDevicePlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  SabianNativeCommonDevicePlatform.instance =
      MockSabianNativeCommonDevicePlatform();

  final SabianNativeCommon initialPlatform = SabianNativeCommon();

  test('$MockSabianNativeCommonDevicePlatform is the default device instance',
      () {
    expect(initialPlatform.device,
        isInstanceOf<MockSabianNativeCommonDevicePlatform>());
  });

  test('getPlatformVersion', () async {
    expect(await initialPlatform.device.getPlatformVersion(), '42');
  });
}
