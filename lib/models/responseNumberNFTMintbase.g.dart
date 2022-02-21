// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responseNumberNFTMintbase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseNumberNFTMintbase _$ResponseNumberNFTMintbaseFromJson(
        Map<String, dynamic> json) =>
    ResponseNumberNFTMintbase(
      jsonrpc: json['jsonrpc'] as String,
      result: ResultEveryNftReference.fromJson(
          json['result'] as Map<String, dynamic>),
      id: json['id'] as int,
    );

Map<String, dynamic> _$ResponseNumberNFTMintbaseToJson(
        ResponseNumberNFTMintbase instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'result': instance.result.toJson(),
      'id': instance.id,
    };
