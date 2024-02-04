import 'package:nft_gallery/models/metadataParas.dart';
import 'package:json_annotation/json_annotation.dart';

part 'resultNFTMetadataParas.g.dart';

@JsonSerializable(explicitToJson: true)
class ResultNFTMetadataParas {
  @JsonKey(name: 'token_id')
  final String tokenId;
  @JsonKey(name: 'owner_id')
  final String ownerId;
  final MetadataParas metadata;
  @JsonKey(name: 'approved_account_ids')
  final Map<dynamic, dynamic>? approvedAccountIds;

  ResultNFTMetadataParas({
    required this.tokenId,
    required this.ownerId,
    required this.metadata,
    this.approvedAccountIds,
  });

  factory ResultNFTMetadataParas.fromJson(Map<String, dynamic> json) =>
      _$ResultNFTMetadataParasFromJson(json);

  Map<String, dynamic> toJson() => _$ResultNFTMetadataParasToJson(this);

  @override
  String toString() {
    return 'ResultNFTMetadataParas{tokenId: $tokenId, ownerId: $ownerId, metadata: $metadata, approvedAccountIds: $approvedAccountIds}';
  }
}
