import 'package:json_annotation/json_annotation.dart';

part 'result.g.dart';

@JsonSerializable()
class Result {
  final List<int> result;
  final List<dynamic> logs;
  @JsonKey(name: 'block_height')
  final int blockHeight;
  @JsonKey(name: 'block_hash')
  final String blockHash;

const Result({
  required this.result,
  required this.logs,
  required this.blockHeight,
  required this.blockHash,
});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  String toString() {
    return 'Result{result: $result, logs: $logs, blockHeight: $blockHeight, blockHash: $blockHash}';
  }
}