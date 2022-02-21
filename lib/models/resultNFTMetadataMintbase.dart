import 'package:audio_player/models/metadataMintbase.dart';
import 'package:json_annotation/json_annotation.dart';

part 'resultNFTMetadataMintbase.g.dart';

@JsonSerializable(explicitToJson: true)
class ResultNFTMetadataMintbase {
  final int id;
  @JsonKey(name: 'owner_id')
  final Object? ownerId;
  final Object? approvals;
  final MetadataMintbase metadata;
  final Object? royalty;
  @JsonKey(name: 'split_owners')
  final Object? splitOwners;
  final String minter;
  final Object? loan;
  @JsonKey(name: 'composeable_stats')
  final Object? composeableStats;
  @JsonKey(name: 'origin_key')
  final Object? originKey;

  ResultNFTMetadataMintbase({
    required this.id,
    this.ownerId,
    this.approvals,
    required this.metadata,
    this.royalty,
    this.splitOwners,
    required this.minter,
    this.loan,
    this.composeableStats,
    this.originKey,
  });

  factory ResultNFTMetadataMintbase.fromJson(Map<String, dynamic> json) =>
      _$ResultNFTMetadataMintbaseFromJson(json);

  Map<String, dynamic> toJson() => _$ResultNFTMetadataMintbaseToJson(this);

  //static const fromJsonFactory = _$ResultNFTMetadataMintbaseFromJson;

  //static const toJsonFactory = _$ResultNFTMetadataMintbaseToJson;

  @override
  String toString() {
    return 'ResultNFTMetadataMintbase{id: $id, ownerId: $ownerId, approvals: $approvals, metadata: $metadata, royalty: $royalty, splitOwners: $splitOwners, minter: $minter, loan: $loan, composeableStats: $composeableStats, originKey: $originKey}';
  }
}
