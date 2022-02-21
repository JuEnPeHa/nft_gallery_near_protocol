// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listNFTParas.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListNFTParas _$ListNFTParasFromJson(List<dynamic> json) => ListNFTParas(
      list: (json as List<dynamic>)
          .map(
              (e) => ResultNFTMetadataParas.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListNFTParasToJson(ListNFTParas instance) =>
    <String, dynamic>{
      'list': instance.list.map((e) => e.toJson()).toList(),
    };
