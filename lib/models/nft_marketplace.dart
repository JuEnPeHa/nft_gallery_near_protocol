class NFTMarketplace {
  final String storeName;
  final String baseUri;
  final int numberNfts;

  NFTMarketplace({
    required this.storeName,
    required this.baseUri,
    required this.numberNfts,
  });

  //factory NFTMarketplace.fromJson(Map<String, dynamic> json) {
  //  return NFTMarketplace(
  //    storeName: json['storeName'] as String,
  //    baseUrl: json['baseUrl'] as String,
  //  );
  //}

  //Map<String, dynamic> toJson() {
  //  return <String, dynamic>{
  //    'storeName': storeName,
  //    'baseUrl': baseUrl,
  //  };
  //}

  @override
  String toString() =>
      'NFTMarketplace { storeName: $storeName, baseUrl: $baseUri }';
}
