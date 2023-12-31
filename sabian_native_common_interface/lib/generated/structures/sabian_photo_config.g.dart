// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../structures/sabian_photo_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoConfig _$PhotoConfigFromJson(Map<String, dynamic> json) => PhotoConfig()
  ..canProcessPermissions = json['canProcessPermissions'] as bool?
  ..galleryAlbumName = json['galleryAlbumName'] as String?
  ..galleryMaximumPhotos = json['galleryMaximumPhotos'] as int
  ..galleryShowCamera = json['galleryShowCamera'] as bool
  ..galleryAllowMultiple = json['galleryAllowMultiple'] as bool
  ..cameraTitle = json['cameraTitle'] as String?
  ..galleryToolBarTitle = json['galleryToolBarTitle'] as String?
  ..galleryPrimaryColor = json['galleryPrimaryColor'] as String?
  ..galleryPrimaryDarkColor = json['galleryPrimaryDarkColor'] as String?
  ..galleryLibraryTitle = json['galleryLibraryTitle'] as String?
  ..galleryAlbumsTitle = json['galleryAlbumsTitle'] as String?
  ..allowEditing = json['allowEditing'] as bool?;

Map<String, dynamic> _$PhotoConfigToJson(PhotoConfig instance) =>
    <String, dynamic>{
      'canProcessPermissions': instance.canProcessPermissions,
      'galleryAlbumName': instance.galleryAlbumName,
      'galleryMaximumPhotos': instance.galleryMaximumPhotos,
      'galleryShowCamera': instance.galleryShowCamera,
      'galleryAllowMultiple': instance.galleryAllowMultiple,
      'cameraTitle': instance.cameraTitle,
      'galleryToolBarTitle': instance.galleryToolBarTitle,
      'galleryPrimaryColor': instance.galleryPrimaryColor,
      'galleryPrimaryDarkColor': instance.galleryPrimaryDarkColor,
      'galleryLibraryTitle': instance.galleryLibraryTitle,
      'galleryAlbumsTitle': instance.galleryAlbumsTitle,
      'allowEditing': instance.allowEditing,
    };
