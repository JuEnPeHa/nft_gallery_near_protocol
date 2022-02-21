import 'package:audio_player/models/result.dart';
import 'package:json_annotation/json_annotation.dart';

part 'marketNFTLogoPetition.g.dart';

@JsonSerializable(explicitToJson: true)
class GenericJsonRpcResponse {
  final String jsonrpc;
  final Result result;
  final int id;

  const GenericJsonRpcResponse({
    required this.jsonrpc,
    required this.result,
    required this.id,
  });

  factory GenericJsonRpcResponse.fromJson(Map<String, dynamic> json) =>
      _$GenericJsonRpcResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GenericJsonRpcResponseToJson(this);

  @override
  String toString() {
    return 'GenericJsonRpcResponse{jsonrpc: $jsonrpc, result: $result, id: $id}';
  }
}
