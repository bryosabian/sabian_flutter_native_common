// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://docs.flutter.dev/cookbook/testing/integration/introduction

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:sabian_native_common/sabian_native_common.dart';
import 'package:sabian_native_common/structures/notification_data.dart';
import 'package:sabian_native_common/structures/photo_data.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('getPlatformVersion', (WidgetTester tester) async {
    final SabianNativeCommon plugin = SabianNativeCommon();
    final String? version = await plugin.device.getPlatformVersion();
    expect(version?.isNotEmpty, true);
  });

  testWidgets("notify", (widgetTester) async {
    final SabianNativeCommon plugin = SabianNativeCommon();
    final response = await plugin.notification.notify(NotificationData());
    // The version string depends on the host platform running the test, so
    // just assert that some non-empty string is returned.
    expect(response.status, "success");
  });

  testWidgets("takePicture", (widgetTester) async {
    final SabianNativeCommon plugin = SabianNativeCommon();
    final response = await plugin.media.takePicture();
    expect(response.status, "success");
  });

  testWidgets("choosePicture", (widgetTester) async {
    final SabianNativeCommon plugin = SabianNativeCommon();
    final response =
        await plugin.media.choosePicture(PhotoData()..galleryMaximumPhotos = 2);
    expect(response.status, "success");
    expect(response.images!.length <= 2, true);
  });
}
