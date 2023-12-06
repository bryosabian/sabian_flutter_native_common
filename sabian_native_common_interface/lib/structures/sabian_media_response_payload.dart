import 'dart:typed_data';

import 'package:sabian_native_common_plugin_interface/structures/sabian_response_payload.dart';

class SabianMediaResponsePayload extends SabianResponsePayload {
  List<Uint8List>? images;

  SabianMediaResponsePayload(String status, this.images) : super(status);
}
