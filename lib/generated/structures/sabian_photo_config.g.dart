// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../structures/sabian_photo_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoConfig _$PhotoConfigFromJson(Map<String, dynamic> json) => PhotoConfig()
  ..galleryAlbumName = json['galleryAlbumName'] as String?
  ..galleryMaximumPhotos = json['galleryMaximumPhotos'] as int
  ..galleryShowCamera = json['galleryShowCamera'] as bool
  ..galleryAllowMultiple = json['galleryAllowMultiple'] as bool
  ..galleryToolBarTitle = json['galleryToolBarTitle'] as String?
  ..galleryPrimaryColor = json['galleryPrimaryColor'] as String?
  ..galleryPrimaryDarkColor = json['galleryPrimaryDarkColor'] as String?;

Map<String, dynamic> _$PhotoConfigToJson(PhotoConfig instance) =>
    <String, dynamic>{
      'galleryAlbumName': instance.galleryAlbumName,
      'galleryMaximumPhotos': instance.galleryMaximumPhotos,
      'galleryShowCamera': instance.galleryShowCamera,
      'galleryAllowMultiple': instance.galleryAllowMultiple,
      'galleryToolBarTitle': instance.galleryToolBarTitle,
      'galleryPrimaryColor': instance.galleryPrimaryColor,
      'galleryPrimaryDarkColor': instance.galleryPrimaryDarkColor,
    };
