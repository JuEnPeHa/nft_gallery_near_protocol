// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resultNFTMetadataParas.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultNFTMetadataParas _$ResultNFTMetadataParasFromJson(
        Map<String, dynamic> json) =>
    ResultNFTMetadataParas(
      tokenId: json['token_id'] as String,
      ownerId: json['owner_id'] as String,
      metadata:
          MetadataParas.fromJson(json['metadata'] as Map<String, dynamic>),
      approvedAccountIds: json['approved_account_ids'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ResultNFTMetadataParasToJson(
        ResultNFTMetadataParas instance) =>
    <String, dynamic>{
      'token_id': instance.tokenId,
      'owner_id': instance.ownerId,
      'metadata': instance.metadata.toJson(),
      'approved_account_ids': instance.approvedAccountIds,
    };
