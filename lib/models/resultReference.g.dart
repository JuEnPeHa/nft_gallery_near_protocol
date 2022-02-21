// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resultReference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultEveryNftReference _$ResultEveryNftReferenceFromJson(
        Map<String, dynamic> json) =>
    ResultEveryNftReference(
      title: json['title'] as String?,
      description: json['description'] as String?,
      media: json['media'] as String?,
      mediaHash: json['media_hash'] as String?,
      copies: json['copies'] as int?,
      expiresAt: json['expires_at'],
      startsAt: json['starts_at'],
      extra: json['extra'] as String?,
      reference: json['reference'] as String,
      referenceHash: json['reference_hash'] as String?,
    );

Map<String, dynamic> _$ResultEveryNftReferenceToJson(
        ResultEveryNftReference instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'media': instance.media,
      'media_hash': instance.mediaHash,
      'copies': instance.copies,
      'expires_at': instance.expiresAt,
      'starts_at': instance.startsAt,
      'extra': instance.extra,
      'reference': instance.reference,
      'reference_hash': instance.referenceHash,
    };
