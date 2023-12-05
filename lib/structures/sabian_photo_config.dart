import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:sabian_native_common/structures/sabian_with_permission.dart';

part '../generated/structures/sabian_photo_config.g.dart';

@JsonSerializable()
class PhotoConfig extends SabianWithPermission {
  String? galleryAlbumName;
  int galleryMaximumPhotos = 5;
  bool galleryShowCamera = false;
  bool galleryAllowMultiple = true;
  String? cameraTitle;
  String? galleryToolBarTitle;
  String? galleryPrimaryColor;
  String? galleryPrimaryDarkColor;
  String? galleryLibraryTitle;
  String? galleryAlbumsTitle;
  bool? allowEditing = false;

  Map<String, dynamic> toMap() => _$PhotoConfigToJson(this);

  String toJson() {
    return jsonEncode(toMap());
  }

  PhotoConfig();

  factory PhotoConfig.fromJson(Map<String, dynamic> map) =>
      _$PhotoConfigFromJson(map);
}
