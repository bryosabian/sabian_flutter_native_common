import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:sabian_native_common_interface/structures/sabian_with_permission.dart';

part '../generated/structures/sabian_notification_config.g.dart';

@JsonSerializable()
class NotificationConfig extends SabianWithPermission {
  String? title;

  String? message;

  List<String>? actions;

  bool showAsProgress = false;

  int? ID;

  String? channel;

  bool hasSound = true;

  bool canVibrate = true;

  bool isBig = true;

  int? progress;

  Map<String, dynamic> toMap() => _$NotificationConfigToJson(this);

  String toJson() {
    return jsonEncode(toMap());
  }

  NotificationConfig();

  factory NotificationConfig.fromJson(Map<String, dynamic> map) =>
      _$NotificationConfigFromJson(map);
}
