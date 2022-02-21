import 'package:json_annotation/json_annotation.dart';

part 'arweaveRawMetadata.g.dart';

@JsonSerializable(explicitToJson: true)
class ArweaveRawMetadata {
  final String category;
  //art, music
  final String description;
  final int copies;
  @JsonKey(name: 'media_hash')
  final String mediaHash;
  //MediaHash es el Hash de la imagen  principal (Thumbnail)
  @JsonKey(name: 'media')
  final String mediaUrl;
  //Media es la url de la imagen principal
  final Object? lock;
  final String? visibility;
  @JsonKey(name: 'youtube_url')
  final String? youtubeUrl;
  @JsonKey(name: 'animation_url')
  final String? animationUrl;
  //¿Musica?
  @JsonKey(name: 'animation_hash')
  final String? animationHash;
  @JsonKey(name: 'document')
  final String? documentUrl;
  @JsonKey(name: 'document_hash')
  final String? documentHash;
  final Object? royalty;
  @JsonKey(name: 'royalty_perc')
  final Object? royaltyPerc;
  @JsonKey(name: 'split_revenue')
  final Object? splitRevenue;
  final Object? extra;
  final String title;
  final String store;
  @JsonKey(name: 'external_url')
  final Object? externalUrl;
  @JsonKey(name: 'type')
  final String typeNft;
  //NEP171
  final Object? tags;

  ArweaveRawMetadata({
    required this.category,
    required this.description,
    required this.copies,
    required this.mediaHash,
    required this.mediaUrl,
    this.lock,
    this.visibility,
    this.youtubeUrl,
    this.animationUrl,
    this.animationHash,
    this.documentUrl,
    this.documentHash,
    this.royalty,
    this.royaltyPerc,
    this.splitRevenue,
    this.extra,
    required this.title,
    required this.store,
    this.externalUrl,
    required this.typeNft,
    this.tags,
  });

  factory ArweaveRawMetadata.fromJson(Map<String, dynamic> json) =>
      _$ArweaveRawMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$ArweaveRawMetadataToJson(this);

  @override
  String toString() {
    return 'ArweaveRawMetadata{category: $category, description: $description, copies: $copies, mediaHash: $mediaHash, mediaUrl: $mediaUrl, lock: $lock, visibility: $visibility, youtubeUrl: $youtubeUrl, animationUrl: $animationUrl, animationHash: $animationHash, documentUrl: $documentUrl, documentHash: $documentHash, royalty: $royalty, royaltyPerc: $royaltyPerc, splitRevenue: $splitRevenue, extra: $extra, title: $title, store: $store, externalUrl: $externalUrl, typeNft: $typeNft, tags: $tags}';
  }
}
