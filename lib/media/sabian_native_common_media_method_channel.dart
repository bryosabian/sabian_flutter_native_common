import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:sabian_native_common/media/sabian_native_common_media_platform.dart';
import 'package:sabian_native_common/structures/sabian_common_native_error.dart';
import 'package:sabian_native_common/structures/sabian_photo_config.dart';

import '../structures/sabian_media_response_payload.dart';

class SabianNativeCommonMediaMethodChannel
    extends SabianNativeCommonMediaPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel =
  const MethodChannel('com.sabian_common_native.methods.media');

  @override
  Future<SabianMediaResponsePayload> takePicture([PhotoConfig? config]) async {
    try {
      dynamic params;
      if (config != null) {
        params = <String, String>{'photoConfig': config.toJson()};
      }
      final response = await methodChannel.invokeMethod("takePicture", params);
      final payload = Map<String, dynamic>.from(response);
      final message = payload["status"] as String;
      final data = payload["data"] as Uint8List;
      final list = [data];
      return SabianMediaResponsePayload(message, list);
    } on PlatformException catch (pe) {
      return Future.error(pe.toNativeError);
    } on Exception catch (e) {
      return Future.error(e.toNativeError);
    }
  }

  @override
  Future<SabianMediaResponsePayload> choosePicture(
      [PhotoConfig? config]) async {
    dynamic params;
    if (config != null) {
      params = <String, String>{'photoConfig': config.toJson()};
    }
    try {
      final response =
      await methodChannel.invokeMethod("choosePicture", params);
      final payload = Map<String, dynamic>.from(response);
      final message = payload["status"] as String;
      final unSerializedData = payload["data"] as List<Object?>;
      final List<Uint8List> data = [];
      for (var element in unSerializedData) {
        data.add(element as Uint8List);
      }
      return SabianMediaResponsePayload(message, data);
    } on PlatformException catch (pe) {
      return Future.error(pe.toNativeError);
    } on Exception catch (e) {
      return Future.error(e.toNativeError);
    }
  }
}
