import 'package:audio_player/models/resultNFTMetadataMintbase.dart';
import 'package:json_annotation/json_annotation.dart';

part 'listNFTMintbase.g.dart';

@JsonSerializable(explicitToJson: true)
class ListNFTMintbase {
  final List<ResultNFTMetadataMintbase> list;

  ListNFTMintbase({
    required this.list,
  });

  factory ListNFTMintbase.fromJson(List<dynamic> json) =>
      _$ListNFTMintbaseFromJson(json);

  Map<String, dynamic> toJson() => _$ListNFTMintbaseToJson(this);

  @override
  String toString() {
    return 'ListNFTMintbase{list: $list}';
  }
}
