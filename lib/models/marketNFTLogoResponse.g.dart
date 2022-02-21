// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marketNFTLogoResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultNFTMarketData _$ResultNFTMarketDataFromJson(Map<String, dynamic> json) =>
    ResultNFTMarketData(
      spec: json['spec'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      icon: json['icon'] as String,
      baseUri: json['base_uri'] as String,
      reference: json['reference'] as String?,
      referenceHash: json['reference_hash'] as String?,
    );

Map<String, dynamic> _$ResultNFTMarketDataToJson(
        ResultNFTMarketData instance) =>
    <String, dynamic>{
      'spec': instance.spec,
      'name': instance.name,
      'symbol': instance.symbol,
      'icon': instance.icon,
      'base_uri': instance.baseUri,
      'reference': instance.reference,
      'reference_hash': instance.referenceHash,
    };
