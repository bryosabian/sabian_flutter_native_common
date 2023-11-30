import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part '../generated/structures/sabian_photo_config.g.dart';

@JsonSerializable()
class PhotoConfig {
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
