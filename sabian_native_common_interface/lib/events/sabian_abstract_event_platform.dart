import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:sabian_native_common_plugin_interface/common/sabian_abstract_platform.dart';

class SabianAbstractEventPlatform extends SabianAbstractPlatform {
  final String _channel;

  @visibleForTesting
  @protected
  late EventChannel channel;

  StreamSubscription? _subscription;

  SabianAbstractEventPlatform(this._channel) {
    channel = EventChannel(_channel);
  }

  @protected
  void onEvent(dynamic payload) {
    throw UnimplementedError("handle() not initialized");
  }

  void register() {
    _subscription = channel.receiveBroadcastStream().listen((message) {
      onEvent(message);
    });
  }

  void unRegister() {
    _subscription?.cancel();
    _subscription = null;
  }
}
