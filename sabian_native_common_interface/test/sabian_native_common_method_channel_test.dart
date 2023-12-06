

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sabian_native_common_plugin_interface/device/sabian_native_common_device_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  SabianNativeCommonDeviceMethodChannel platform = SabianNativeCommonDeviceMethodChannel();

  const MethodChannel channel = MethodChannel('com.sabian_common_native.methods.device');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
