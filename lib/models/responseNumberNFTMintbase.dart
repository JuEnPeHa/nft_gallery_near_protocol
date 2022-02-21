import 'package:audio_player/models/resultReference.dart';
import 'package:json_annotation/json_annotation.dart';

part 'responseNumberNFTMintbase.g.dart';

@JsonSerializable(explicitToJson: true)
class ResponseNumberNFTMintbase {
  final String jsonrpc;
  final ResultEveryNftReference result;
  final int id;

  const ResponseNumberNFTMintbase({
    required this.jsonrpc,
    required this.result,
    required this.id,
  });

  factory ResponseNumberNFTMintbase.fromJson(Map<String, dynamic> json) =>
      _$ResponseNumberNFTMintbaseFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseNumberNFTMintbaseToJson(this);

  @override
  String toString() {
    return 'ResponseNumberNFTMintbase{jsonrpc: $jsonrpc, id: $id, result: $result}';
  }
}
