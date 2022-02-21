import 'dart:convert';
import 'dart:math';

import 'package:audio_player/interceptor/dio_connectivity_request_retrier.dart';
import 'package:audio_player/interceptor/retry_interceptor.dart';
import 'package:audio_player/models/arweaveRawMetadata.dart';
import 'package:audio_player/models/listNFTMintbase.dart';
import 'package:audio_player/models/listNFTParas.dart';
import 'package:audio_player/models/marketNFTLogoPetition.dart';
import 'package:audio_player/models/marketNFTLogoResponse.dart';
import 'package:audio_player/models/nft.dart';
import 'package:audio_player/models/nft_marketplace.dart';
import 'package:audio_player/models/resultNFTMetadataMintbase.dart';
import 'package:audio_player/models/resultNFTMetadataParas.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:audio_player/constants.dart';

var rng = Random();

Future<List<dynamic>> fetchNFTMarketplaces(String aID, bool isM) async {
  var likelyContracts = isM
      ? Uri.parse(ACCOUNT_HELPER_URL + '/account/' + aID + '/likelyNFTs')
      : Uri.parse(
          ACCOUNT_HELPER_URL_TESTNET + '/account/' + aID + '/likelyNFTs');

  var response = await http.get(likelyContracts, headers: HEADERS);

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load likely NFTs');
  }
}

Future<List<NFTMarketplace>> fetchNFTMarketPlaceImages(
    {required List<dynamic> marketplaces,
    required List<int> numberNfts}) async {
  const methodName = "nft_metadata";
  var url = Uri.parse(RPC_URL);
  List<NFTMarketplace> nftMarketplaces = [];
  for (var i = 0; i < marketplaces.length; i++) {
    var requestBody =
        getHttpBody(methodName: methodName, marketplace: marketplaces[i]);
    var response =
        await http.post(url, body: json.encode(requestBody), headers: HEADERS);
    if (response.statusCode == 200) {
      nftMarketplaces.add(NFTMarketplace(
          storeName: marketplaces[i],
          baseUri: getBaseUri(
              GenericJsonRpcResponse.fromJson(json.decode(response.body))),
          numberNfts: numberNfts[i]));
    }
  }
  //print(nftMarketplaces);
  print("HOLAHOLAHOLA" + utf8.decode([34, 52, 34]));
  return nftMarketplaces;
}

Future<List<ResultNFTMetadataParas>> fetchNFTMetadataParas(
    {String marketplace = "x.paras.near",
    required String accountId,
    String fromIndex = "0",
    int indexLimit = 4}) async {
  const methodName = "nft_tokens_for_owner";
  var url = Uri.parse(RPC_URL);
  var args = {
    "account_id": accountId,
    "from_index": fromIndex,
    "limit": indexLimit
  };
  var argsBase64 = base64.encode(utf8.encode(json.encode(args)));
  print(argsBase64);
  var requestBody = getHttpBody(
      methodName: methodName, marketplace: marketplace, argsBase64: argsBase64);
  var response =
      await http.post(url, body: json.encode(requestBody), headers: HEADERS);
  if (response.statusCode == 200) {
    //print(json.decode(response.body));
    var generic = GenericJsonRpcResponse.fromJson(json.decode(response.body));
    //print(decodeBuffer(bufferForDecode: generic.result.result));
    var inside = json.decode(
        json.encode(decodeBuffer(bufferForDecode: generic.result.result)));
    ListNFTParas lista = ListNFTParas.fromJson(inside);
    return lista.list;
  } else {
    throw Exception('Failed to load NFTs');
  }
}

Future<List<NftFinal>> fetchNFTMetadataAll({
  required List<NFTMarketplace> marketplaces,
  required String accountId,
  String fromIndex = "0",
  //int indexLimit = 4,
}) async {
  Uri url = Uri.parse(RPC_URL);
  List<NftFinal> resultado = [];
  int id = 0;
  //Esto retorna una lista con los números de los NFT que tengas en la store de Mintbase
  //Eso hay que pedir de nuevo par aobtener la metadata
  for (var e = 0; e < marketplaces.length; e++) {
    int indexLimit = marketplaces[e].numberNfts;
    String marketplace = marketplaces[e].storeName;
    bool isParas = marketplace.contains("paras");
    String methodName =
        isParas ? "nft_tokens_for_owner" : "nft_tokens_for_owner";
    Map<String, Object> args = isParas
        ? {
            "account_id": accountId,
            "from_index": fromIndex,
            "limit": indexLimit
          }
        : {"account_id": accountId};
    String argsBase64 = base64.encode(utf8.encode(json.encode(args)));
    //print(argsBase64);
    var requestBody = getHttpBody(
        methodName: methodName,
        marketplace: marketplace,
        argsBase64: argsBase64);
    var response =
        await http.post(url, body: json.encode(requestBody), headers: HEADERS);
    //print(response.body);
    if (response.statusCode == 200) {
      //print(json.decode(response.body));
      var generic = GenericJsonRpcResponse.fromJson(json.decode(response.body));
      print(generic.result.result);
      var inside = json.decode(
          json.encode(decodeBuffer(bufferForDecode: generic.result.result)));
      print(inside);
      if (isParas) {
        ListNFTParas lista = ListNFTParas.fromJson(inside);
        List<ResultNFTMetadataParas> insideLista = lista.list;
        for (var o = 0; o < insideLista.length; o++) {
          ResultNFTMetadataParas metadata = insideLista[o];
          print(metadata);
          resultado.add(NftFinal(
              id: id,
              title: metadata.metadata.title,
              description: metadata.metadata.description,
              principalImageUrl:
                  marketplaces[e].baseUri + '/' + metadata.metadata.media,
              musicOrVideoUrl: "",
              documentUrl: "",
              isMusic: false,
              isDoc: false,
              isVideo: false,
              artist: marketplaces[e].storeName,
              category: ""));
          id++;
        }
      } else {
        ListNFTMintbase lista = ListNFTMintbase.fromJson(inside);
        List<ResultNFTMetadataMintbase> insideLista = lista.list;
        for (var u = 0; u < insideLista.length; u++) {
          ResultNFTMetadataMintbase metadata = insideLista[u];
          ArweaveRawMetadata arweaveRawMetadata = await fetchNftFinalMintbase(
              baseUri: marketplaces[e].baseUri,
              lastPartUrl: "/" + metadata.metadata.reference);
          print(metadata);
          resultado.add(NftFinal(
              id: id,
              title: arweaveRawMetadata.title,
              description: arweaveRawMetadata.description,
              principalImageUrl: arweaveRawMetadata.mediaUrl,
              musicOrVideoUrl: arweaveRawMetadata.animationUrl ?? '',
              documentUrl: arweaveRawMetadata.documentUrl ?? '',
              isMusic: arweaveRawMetadata.category == 'music',
              isDoc: arweaveRawMetadata.documentUrl != "",
              isVideo: arweaveRawMetadata.category != 'music' &&
                  arweaveRawMetadata.animationUrl != "",
              artist: arweaveRawMetadata.store,
              category: arweaveRawMetadata.category));
          id++;
        }
        //return lista.list;
      }
    } else {
      //} else if (response.statusCode == 404) {
      return [];
      // print(decodeBuffer(bufferForDecode: generic.result.result));
    }
  }
  return resultado;
}

Future<int> fetchNumberNFTParas({
  String marketplace = "x.paras.near",
  required String accountId,
}) async {
  const methodName = "nft_supply_for_owner";
  var url = Uri.parse(RPC_URL);
  var args = {
    "account_id": accountId,
  };
  var argsBase64 = base64.encode(utf8.encode(json.encode(args)));
  print(argsBase64);
  var requestBody = getHttpBody(
      methodName: methodName, marketplace: marketplace, argsBase64: argsBase64);
  var response =
      await http.post(url, body: json.encode(requestBody), headers: HEADERS);
  if (response.statusCode == 200) {
    print(json.decode(response.body));
    var generic = GenericJsonRpcResponse.fromJson(json.decode(response.body));
    print(decodeBufferIntForNumberNftOnAccount(
        bufferForDecode: generic.result.result));
    var inside = json.decode(json.encode(decodeBufferIntForNumberNftOnAccount(
        bufferForDecode: generic.result.result)));
    if (inside is int) {
      return inside;
    } else {
      return 0;
    }
  } else {
    throw Exception('Failed to load NFTs');
  }
}

Future<List<int>> fetchNumberNFTAll({
  required List<dynamic> marketplaces,
  required String accountId,
}) async {
  List<int> number = [];
  const methodName = "nft_supply_for_owner";
  var url = Uri.parse(RPC_URL);
  var args = {
    "account_id": accountId,
  };
  var argsBase64 = base64.encode(utf8.encode(json.encode(args)));
  print(argsBase64);
  for (var i = 0; i < marketplaces.length; i++) {
    var marketplace = marketplaces[i];
    var requestBody = getHttpBody(
        methodName: methodName,
        marketplace: marketplace,
        argsBase64: argsBase64);
    var response =
        await http.post(url, body: json.encode(requestBody), headers: HEADERS);
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      var generic = GenericJsonRpcResponse.fromJson(json.decode(response.body));
      print(decodeBufferIntForNumberNftOnAccount(
          bufferForDecode: generic.result.result));
      var inside = json.decode(json.encode(decodeBufferIntForNumberNftOnAccount(
          bufferForDecode: generic.result.result)));
      if (inside is int) {
        number.add(inside);
      } else {
        number.add(0);
      }
    }
  }
  return number;
}

Future<ArweaveRawMetadata> fetchNftFinalMintbase({
  required String baseUri,
  required String lastPartUrl,
}) async {
  Dio dio = Dio();
  dio.interceptors.add(RetryOnConnectionChangeInterceptor(
      requestRetrier: DioConnectivityRequestRetrier(
    dio: Dio(),
    connectivity: Connectivity(),
  )));
  var url = baseUri + lastPartUrl;
  //var url = Uri.parse(baseUri + lastPartUrl);
  print("url: EEEEEEEEEEEEEEEEEEEEE" + url.toString());
  var response = await dio.get(url);
  //var response = await http.get(url, headers: HEADERS);
  if (response.statusCode == 200) {
    ArweaveRawMetadata generic =
        ArweaveRawMetadata.fromJson(response.data);
        print("GENERICGENERICGENERICGENERICGENERIC" + generic.toString());
    return generic;
  } else {
    throw Exception('Failed to load NFTs');
  }
}

int decodeBufferIntForNumberNftOnAccount({required List<int> bufferForDecode}) {
  var bufferDecoded = utf8.decode(bufferForDecode);
  final String decoded = json.decode(bufferDecoded);
  return int.parse(decoded);
}

List<dynamic> decodeBuffer({required List<int> bufferForDecode}) {
  var bufferDecoded = utf8.decode(bufferForDecode);
  final List<dynamic> decoded = json.decode(bufferDecoded);
  //print(decoded);
  return decoded;
}

List<String> getMarketplacesClean({required List<dynamic> marketplaces}) {
  List<String> marketplacesClean = [];
  for (var i = 0; i < marketplaces.length; i++) {
    if (marketplaces[i].contains('mintbase') ||
        marketplaces[i].contains('paras')) {
      marketplacesClean.add(marketplaces[i].toString());
    }
  }
  return marketplacesClean;
}

Map<String, Object> getHttpBody(
    {required String methodName,
    required String marketplace,
    String argsBase64 = "e30="}) {
  return {
    'jsonrpc': '2.0',
    'method': "query",
    "id": rng.nextInt(10000),
    'params': {
      "request_type": "call_function",
      "account_id": marketplace,
      "method_name": methodName,
      "args_base64": argsBase64,
      "finality": "optimistic"
    },
  };
}

bool isValidAccount(String accountID) {
  return accountID.contains(".near") || accountID.contains(".testnet");
}

bool isMainnet(String accountID) {
  if (accountID.contains("testnet")) {
    return false;
  } else {
    return true;
  }
}

String getBaseUri(GenericJsonRpcResponse raw) {
  var bufferForDecode = raw.result.result;
  var bufferDecoded = utf8.decode(bufferForDecode);
  final Map<String, dynamic> decoded = json.decode(bufferDecoded);
  final ResultNFTMarketData resultMarketData =
      ResultNFTMarketData.fromJson(decoded);
  return resultMarketData.baseUri;
}

List<MarketplacesClean> getMarketplacesWithNfts(
    {required List<dynamic> nftMarketplaces, required List<int> numberNfts}) {
  List<MarketplacesClean> marketplacesClean = [];
  List<String> marketplacesNotClean = [];
  for (var i = 0; i < nftMarketplaces.length; i++) {
    if (numberNfts[i] != 0) {
      marketplacesClean.add(MarketplacesClean(
          marketplace: nftMarketplaces[i].toString(),
          numberNftFromMarketplace: numberNfts[i]));
    } else {
      marketplacesNotClean.add(nftMarketplaces[i].toString());
    }
  }
  print(marketplacesNotClean);
  return marketplacesClean;
}
