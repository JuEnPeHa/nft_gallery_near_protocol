part of 'metadataParas.dart';

MetadataParas _$MetadataParasFromJson(Map<String, dynamic> json) =>
    MetadataParas(
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      media: json['media'] as String,
      mediaHash: json['mediaHash'] as String? ?? '',
      copies: json['copies'] as int? ?? 0,
      issuedAt: json['issued_at'] as String,
      expiresAt: json['expires_at'] as Object?,
      startsAt: json['starts_at'] as Object?,
      updatedAt: json['updated_at'] as String?,
      extra: json['extra'] as String?,
      reference: json['reference'] as String?,
      referenceHash: json['reference_hash'] as String?,
    );

Map<String, dynamic> _$MetadataParasToJson(MetadataParas instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'media': instance.media,
      'mediaHash': instance.mediaHash,
      'copies': instance.copies,
      'issued_at': instance.issuedAt,
      'expires_at': instance.expiresAt,
      'starts_at': instance.startsAt,
      'updated_at': instance.updatedAt,
      'extra': instance.extra,
      'reference': instance.reference,
      'reference_hash': instance.referenceHash,
    };
