// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      result: (json['result'] as List<dynamic>).map((e) => e as int).toList(),
      logs: json['logs'] as List<dynamic>,
      blockHeight: json['block_height'] as int,
      blockHash: json['block_hash'] as String,
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'result': instance.result,
      'logs': instance.logs,
      'block_height': instance.blockHeight,
      'block_hash': instance.blockHash,
    };
