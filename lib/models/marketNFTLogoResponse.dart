import 'package:json_annotation/json_annotation.dart';

part 'marketNFTLogoResponse.g.dart';

@JsonSerializable()
class ResultNFTMarketData {
  final String spec;
  final String name;
  final String symbol;
  final String icon;
  @JsonKey(name: "base_uri")
  final String baseUri;
  final String? reference;
  @JsonKey(name: "reference_hash")
  final String? referenceHash;

  const ResultNFTMarketData({
    required this.spec,
    required this.name,
    required this.symbol,
    required this.icon,
    required this.baseUri,
    required this.reference,
    required this.referenceHash,
  });

  factory ResultNFTMarketData.fromJson(Map<String, dynamic> json) =>
      _$ResultNFTMarketDataFromJson(json);

  Map<String, dynamic> toJson() => _$ResultNFTMarketDataToJson(this);

  @override
  String toString() {
    return 'ResultNFTMarketData{spec: $spec, name: $name, symbol: $symbol, icon: $icon, baseUri: $baseUri, reference: $reference, referenceHash: $referenceHash}';
  }
}
