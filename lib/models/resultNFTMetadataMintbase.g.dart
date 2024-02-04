part of 'resultNFTMetadataMintbase.dart';

ResultNFTMetadataMintbase _$ResultNFTMetadataMintbaseFromJson(
        Map<String, dynamic> json) =>
    ResultNFTMetadataMintbase(
      id: json['id'] as int?,
      ownerId: json['owner_id'] as Object?,
      approvals: json['approvals'] as Object?,
      metadata:
          MetadataMintbase.fromJson(json['metadata'] as Map<String, dynamic>),
      royalty: json['royalty'] as Object?,
      splitOwners: json['split_owners'] as Object?,
      minter: json['minter'] as String,
      loan: json['loan'] as Object?,
      composeableStats: json['composeable_stats'] as Object?,
      originKey: json['origin_key'] as Object?,
    );

Map<String, dynamic> _$ResultNFTMetadataMintbaseToJson(
        ResultNFTMetadataMintbase instance) =>
    <String, dynamic>{
      'id': instance.id,
      'owner_id': instance.ownerId,
      'approvals': instance.approvals,
      'metadata': instance.metadata.toJson(),
      'royalty': instance.royalty,
      'split_owners': instance.splitOwners,
      'minter': instance.minter,
      'loan': instance.loan,
      'composeable_stats': instance.composeableStats,
      'origin_key': instance.originKey,
    };
