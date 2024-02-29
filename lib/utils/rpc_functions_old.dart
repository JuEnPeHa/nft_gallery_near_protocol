// Future<List<NFTMarketplace>> fetchNFTMarketPlaceImages(
//     {required List<dynamic> marketplaces,
//     required List<int> numberNfts}) async {
//   const methodName = "nft_metadata";
//   var url = Uri.parse(RPC_URL);
//   List<NFTMarketplace> nftMarketplaces = [];
//   for (var i = 0; i < marketplaces.length; i++) {
//     var requestBody =
//         getHttpBody(methodName: methodName, marketplace: marketplaces[i]);
//     var response =
//         await http.post(url, body: json.encode(requestBody), headers: HEADERS);
//     if (response.statusCode == 200) {
//       nftMarketplaces.add(NFTMarketplace(
//           storeName: marketplaces[i],
//           baseUri: getBaseUri(
//               GenericJsonRpcResponse.fromJson(json.decode(response.body))),
//           numberNfts: numberNfts[i]));
//     }
//   }
//   //print(nftMarketplaces);
//   print("HOLAHOLAHOLA" + utf8.decode([34, 52, 34]));
//   return nftMarketplaces;
// }

// Future<List<ResultNFTMetadataParas>> fetchNFTMetadataParas(
//     {String marketplace = "x.paras.near",
//     required String accountId,
//     String fromIndex = "0",
//     int indexLimit = 4}) async {
//   const methodName = "nft_tokens_for_owner";
//   var url = Uri.parse(RPC_URL);
//   var args = {
//     "account_id": accountId,
//     "from_index": fromIndex,
//     "limit": indexLimit
//   };
//   var argsBase64 = base64.encode(utf8.encode(json.encode(args)));
//   print(argsBase64);
//   var requestBody = getHttpBody(
//       methodName: methodName, marketplace: marketplace, argsBase64: argsBase64);
//   var response =
//       await http.post(url, body: json.encode(requestBody), headers: HEADERS);
//   if (response.statusCode == 200) {
//     //print(json.decode(response.body));
//     var generic = GenericJsonRpcResponse.fromJson(json.decode(response.body));
//     //print(decodeBuffer(bufferForDecode: generic.result.result));
//     var inside = json.decode(
//         json.encode(decodeBuffer(bufferForDecode: generic.result.result)));
//     ListNFTParas lista = ListNFTParas.fromJson(inside);
//     return lista.list;
//   } else {
//     throw Exception('Failed to load NFTs');
//   }
// }

// Future<int> fetchNumberNFTParas({
//   String marketplace = "x.paras.near",
//   required String accountId,
// }) async {
//   const methodName = "nft_supply_for_owner";
//   var url = Uri.parse(RPC_URL);
//   var args = {
//     "account_id": accountId,
//   };
//   var argsBase64 = base64.encode(utf8.encode(json.encode(args)));
//   print(argsBase64);
//   var requestBody = getHttpBody(
//       methodName: methodName, marketplace: marketplace, argsBase64: argsBase64);
//   var response =
//       await http.post(url, body: json.encode(requestBody), headers: HEADERS);
//   if (response.statusCode == 200) {
//     print(json.decode(response.body));
//     var generic = GenericJsonRpcResponse.fromJson(json.decode(response.body));
//     print(decodeBufferIntForNumberNftOnAccount(
//         bufferForDecode: generic.result.result));
//     var inside = json.decode(json.encode(decodeBufferIntForNumberNftOnAccount(
//         bufferForDecode: generic.result.result)));
//     if (inside is int) {
//       return inside;
//     } else {
//       return 0;
//     }
//   } else {
//     throw Exception('Failed to load NFTs');
//   }
// }

