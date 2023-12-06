import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:sabian_native_common_plugin_interface/device/sabian_native_common_device_platform.dart';
import 'package:sabian_native_common_plugin_interface/structures/sabian_common_native_error.dart';

class SabianNativeCommonDeviceMethodChannel
    extends SabianNativeCommonDevicePlatform {
  @visibleForTesting
  final methodChannel =
      const MethodChannel('com.sabian_common_native.methods.device');

  @override
  Future<String> getPlatformVersion() async {
    try {
      final response =
          await methodChannel.invokeMethod<String?>("getPlatformVersion");
      return response ?? "Unknown";
    } on PlatformException catch (pe) {
      return Future.error(pe.toNativeError);
    } on Exception catch (e) {
      return Future.error(e.toNativeError);
    }
  }
}
