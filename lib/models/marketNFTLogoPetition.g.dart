// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marketNFTLogoPetition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericJsonRpcResponse _$GenericJsonRpcResponseFromJson(
        Map<String, dynamic> json) =>
    GenericJsonRpcResponse(
      jsonrpc: json['jsonrpc'] as String,
      result: Result.fromJson(json['result'] as Map<String, dynamic>),
      id: json['id'] as int,
    );

Map<String, dynamic> _$GenericJsonRpcResponseToJson(
        GenericJsonRpcResponse instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'result': instance.result.toJson(),
      'id': instance.id,
    };
