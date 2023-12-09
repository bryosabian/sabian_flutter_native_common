import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sabian_native_common_interface/sabian_native_common_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  SabianNativeCommonPlatform platform = SabianNativeCommonPlatform();

  const MethodChannel channel =
  MethodChannel('com.sabian_common_native.methods.device');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
          (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.device.getPlatformVersion(), '42');
  });
}
