import 'package:nft_gallery/models/resultNFTMetadataParas.dart';
import 'package:json_annotation/json_annotation.dart';

part 'listNFTParas.g.dart';

@JsonSerializable(explicitToJson: true)
class ListNFTParas {
  final List<ResultNFTMetadataParas> list;

  ListNFTParas({
    required this.list,
  });

  factory ListNFTParas.fromJson(List<dynamic> json) =>
      _$ListNFTParasFromJson(json);

  Map<String, dynamic> toJson() => _$ListNFTParasToJson(this);

  @override
  String toString() {
    return 'ListNFTParas{list: $list}';
  }
}
