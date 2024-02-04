// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arweaveRawMetadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArweaveRawMetadata _$ArweaveRawMetadataFromJson(Map<String, dynamic> json) =>
    ArweaveRawMetadata(
      category: json['category'] ??= "",
      description: json['description'] as String? ?? '',
      copies: json['copies'] ??= 0,
      mediaHash: json['media_hash'] as String? ?? '',
      mediaUrl: json['media'] as String,
      lock: json['lock'] ??= null,
      visibility: json['visibility'] ??= "",
      youtubeUrl: json['youtube_url'] ??= "",
      animationUrl: json['animation_url'] ??= "",
      animationHash: json['animation_hash'] ??= "",
      documentUrl: json['document'] ??= "",
      documentHash: json['document_hash'] ??= "",
      royalty: json['royalty'] ??= null,
      royaltyPerc: json['royalty_perc'] ??= null,
      splitRevenue: json['split_revenue'] ??= null,
      extra: json['extra'],
      title: json['title'] as String,
      store: json['store'] ??= "",
      externalUrl: json['external_url'],
      typeNft: json['type'] ??= "",
      tags: json['tags'] ??= null,
    );

Map<String, dynamic> _$ArweaveRawMetadataToJson(ArweaveRawMetadata instance) =>
    <String, dynamic>{
      'category': instance.category,
      'description': instance.description,
      'copies': instance.copies,
      'media_hash': instance.mediaHash,
      'media': instance.mediaUrl,
      'lock': instance.lock,
      'visibility': instance.visibility,
      'youtube_url': instance.youtubeUrl,
      'animation_url': instance.animationUrl,
      'animation_hash': instance.animationHash,
      'document': instance.documentUrl,
      'document_hash': instance.documentHash,
      'royalty': instance.royalty,
      'royalty_perc': instance.royaltyPerc,
      'split_revenue': instance.splitRevenue,
      'extra': instance.extra,
      'title': instance.title,
      'store': instance.store,
      'external_url': instance.externalUrl,
      'type': instance.typeNft,
      'tags': instance.tags,
    };
