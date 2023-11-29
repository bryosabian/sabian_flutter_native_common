import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sabian_native_common/sabian_native_common_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelSabianNativeCommon platform = MethodChannelSabianNativeCommon();
  const MethodChannel channel = MethodChannel('sabian_native_common');

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
