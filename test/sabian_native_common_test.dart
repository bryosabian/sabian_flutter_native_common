import 'package:flutter_test/flutter_test.dart';
import 'package:sabian_native_common/sabian_native_common.dart';
import 'package:sabian_native_common/sabian_native_common_platform_interface.dart';
import 'package:sabian_native_common/sabian_native_common_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSabianNativeCommonPlatform
    with MockPlatformInterfaceMixin
    implements SabianNativeCommonPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SabianNativeCommonPlatform initialPlatform =
      SabianNativeCommonPlatform.instance;

  test('$MethodChannelSabianNativeCommon is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSabianNativeCommon>());
  });

  test('getPlatformVersion', () async {
    SabianNativeCommon sabianNativeCommonPlugin = SabianNativeCommon();
    MockSabianNativeCommonPlatform fakePlatform =
        MockSabianNativeCommonPlatform();
    SabianNativeCommonPlatform.instance = fakePlatform;

    expect(await sabianNativeCommonPlugin.platform.getPlatformVersion(), '42');
  });
}
