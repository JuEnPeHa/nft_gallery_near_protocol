import 'package:hive_flutter/hive_flutter.dart';

part 'nft.g.dart';

class NFT {
  final int id;
  final String title;
  final String description;
  final String baseUri;
  final String lastPartUrl;
  final String type;
  final String marketplace;

  NFT({
    required this.id,
    required this.title,
    required this.description,
    required this.baseUri,
    required this.lastPartUrl,
    required this.type,
    required this.marketplace,
  });

  factory NFT.fromJson(Map<String, dynamic> json) => NFT(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        baseUri: json["baseUri"],
        lastPartUrl: json["lastPartUrl"],
        type: json["type"],
        marketplace: json["marketplace"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "baseUri": baseUri,
        "lastPartUrl": lastPartUrl,
        "type": type,
        "marketplace": marketplace,
      };

  @override
  String toString() {
    return 'NFT{id: $id, title: $title, description: $description, baseUri: $baseUri, lastPartUrl: $lastPartUrl, type: $type, marketplace: $marketplace}';
  }
}

class MarketplacesWithNumberOfNFTs {
  final String marketplace;
  final int numberNftFromMarketplace;

  MarketplacesWithNumberOfNFTs({
    required this.marketplace,
    required this.numberNftFromMarketplace,
  });

  factory MarketplacesWithNumberOfNFTs.fromJson(Map<String, dynamic> json) =>
      MarketplacesWithNumberOfNFTs(
        marketplace: json["marketplace"],
        numberNftFromMarketplace: json["numberNftFromMarketplace"],
      );

  Map<String, dynamic> toJson() => {
        "marketplace": marketplace,
        "numberNftFromMarketplace": numberNftFromMarketplace,
      };

  @override
  String toString() {
    return 'MarketplacesWithNumberOfNFTs{marketplace: $marketplace, numberNftFromMarketplace: $numberNftFromMarketplace}';
  }
}

class NftFinalMintbase {
  final int id;
  final String title;
  final String description;
  final String principalImageUrl;
  final String musicOrVideoUrl;
  final bool isMusic;
  final bool isDoc;
  final bool isVideo;
  final String artist;
  final String category;

  NftFinalMintbase({
    required this.id,
    required this.title,
    required this.description,
    required this.principalImageUrl,
    required this.musicOrVideoUrl,
    required this.isMusic,
    required this.isDoc,
    required this.isVideo,
    required this.artist,
    required this.category,
  });

  factory NftFinalMintbase.fromJson(Map<String, dynamic> json) =>
      NftFinalMintbase(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        principalImageUrl: json["principalImageUrl"],
        isMusic: json["isMusic"],
        isDoc: json["isDoc"],
        isVideo: json["isVideo"],
        artist: json["artist"],
        category: json["category"],
        musicOrVideoUrl: json["musicOrVideoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "principalImageUrl": principalImageUrl,
        "isMusic": isMusic,
        "isDoc": isDoc,
        "isVideo": isVideo,
        "artist": artist,
        "category": category,
        "musicOrVideoUrl": musicOrVideoUrl,
      };

  @override
  String toString() {
    return 'NftFinalMintbase{id: $id, title: $title, description: $description, principalImageUrl: $principalImageUrl, isMusic: $isMusic, isDoc: $isDoc, isVideo: $isVideo, artist: $artist, category: $category, musicOrVideoUrl: $musicOrVideoUrl}';
  }
}

@HiveType(typeId: 1)
class NftFinal extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String principalImageUrl;
  @HiveField(4)
  final String musicOrVideoUrl;
  @HiveField(5)
  final String documentUrl;
  @HiveField(6)
  final bool isMusic;
  @HiveField(7)
  final bool isDoc;
  @HiveField(8)
  final bool isVideo;
  @HiveField(9)
  final String artist;
  @HiveField(10)
  final String category;

  NftFinal({
    required this.id,
    required this.title,
    required this.description,
    required this.principalImageUrl,
    required this.musicOrVideoUrl,
    required this.documentUrl,
    required this.isMusic,
    required this.isDoc,
    required this.isVideo,
    required this.artist,
    required this.category,
  });

  factory NftFinal.fromJson(Map<String, dynamic> json) => NftFinal(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        principalImageUrl: json["principalImageUrl"],
        isMusic: json["isMusic"],
        isDoc: json["isDoc"],
        isVideo: json["isVideo"],
        artist: json["artist"],
        category: json["category"],
        musicOrVideoUrl: json["musicOrVideoUrl"],
        documentUrl: json["documentUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "principalImageUrl": principalImageUrl,
        "isMusic": isMusic,
        "isDoc": isDoc,
        "isVideo": isVideo,
        "artist": artist,
        "category": category,
        "musicOrVideoUrl": musicOrVideoUrl,
        "documentUrl": documentUrl,
      };

  @override
  String toString() {
    return 'NftFinal{id: $id, title: $title, description: $description, principalImageUrl: $principalImageUrl, documentUrl: $documentUrl, isMusic: $isMusic, isDoc: $isDoc, isVideo: $isVideo, artist: $artist, category: $category, musicOrVideoUrl: $musicOrVideoUrl}';
  }
}
