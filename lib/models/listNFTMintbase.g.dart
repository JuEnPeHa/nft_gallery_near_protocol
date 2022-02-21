part of 'listNFTMintbase.dart';

ListNFTMintbase _$ListNFTMintbaseFromJson(List<dynamic> json) =>
    ListNFTMintbase(
      list: (json as List<dynamic>)
          .map((e) =>
              ResultNFTMetadataMintbase.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListNFTMintbaseToJson(ListNFTMintbase instance) =>
    <String, dynamic>{
      'list': instance.list.map((e) => e.toJson()).toList(),
    };
