// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../structures/sabian_notification_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationConfig _$NotificationConfigFromJson(Map<String, dynamic> json) =>
    NotificationConfig()
      ..canProcessPermissions = json['canProcessPermissions'] as bool?
      ..title = json['title'] as String?
      ..message = json['message'] as String?
      ..actions =
          (json['actions'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..showAsProgress = json['showAsProgress'] as bool
      ..ID = json['ID'] as int?
      ..channel = json['channel'] as String?
      ..hasSound = json['hasSound'] as bool
      ..canVibrate = json['canVibrate'] as bool
      ..isBig = json['isBig'] as bool
      ..progress = json['progress'] as int?;

Map<String, dynamic> _$NotificationConfigToJson(NotificationConfig instance) =>
    <String, dynamic>{
      'canProcessPermissions': instance.canProcessPermissions,
      'title': instance.title,
      'message': instance.message,
      'actions': instance.actions,
      'showAsProgress': instance.showAsProgress,
      'ID': instance.ID,
      'channel': instance.channel,
      'hasSound': instance.hasSound,
      'canVibrate': instance.canVibrate,
      'isBig': instance.isBig,
      'progress': instance.progress,
    };
