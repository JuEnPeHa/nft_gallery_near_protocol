import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:nft_gallery/constants.dart';
import 'package:nft_gallery/interceptor/dio_connectivity_request_retrier.dart';
import 'package:nft_gallery/interceptor/retry_interceptor.dart';
import 'package:nft_gallery/models/arweaveRawMetadata.dart';
import 'package:nft_gallery/models/listNFTMintbase.dart';
import 'package:nft_gallery/models/listNFTParas.dart';
import 'package:nft_gallery/models/marketNFTLogoPetition.dart';
import 'package:nft_gallery/models/marketNFTLogoResponse.dart';
import 'package:nft_gallery/models/nft.dart';
import 'package:nft_gallery/models/nft_marketplace.dart';
import 'package:nft_gallery/models/resultNFTMetadataMintbase.dart';
import 'package:nft_gallery/models/resultNFTMetadataParas.dart';

var rng = Random();

// Call to the RPC to get the likely NFT marketplaces (It returns a list of strings and includes Spam)
Future<List<String>> fetchNFTMarketplaces(String aID, bool isM) async {
  var likelyContracts = isM
      ? Uri.parse(ACCOUNT_HELPER_URL + '/account/' + aID + '/likelyNFTs')
      : Uri.parse(
          ACCOUNT_HELPER_URL_TESTNET + '/account/' + aID + '/likelyNFTs');
  developer.log(likelyContracts.toString());

  var response = await http.get(likelyContracts, headers: HEADERS);

  // response.body is: "["mintbase.near","paras.near"]" or "[]" so need to parse

  if (response.statusCode == 200) {
    final List<dynamic> likelyNFTs = json.decode(response.body);
    print(likelyNFTs);
    return likelyNFTs.map((e) => e.toString()).toList();
  } else {
    throw Exception('Failed to load likely NFTs');
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
                  '${marketplaces[e].baseUri}/${metadata.metadata.media}',
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
              lastPartUrl: "/${metadata.metadata.reference}");
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

Future<List<NFTMarketplace>> fetchNFTMarketPlaceImagesConcurrent({
  required List<String> marketplaces,
  required List<int> numberNfts,
}) async {
  const methodName = "nft_metadata";
  var url = Uri.parse(RPC_URL);
  List<Future<NFTMarketplace>> futures = [];
  for (var i = 0; i < marketplaces.length; i++) {
    var requestBody =
        getHttpBody(methodName: methodName, marketplace: marketplaces[i]);
    futures.add(http
        .post(url, body: json.encode(requestBody), headers: HEADERS)
        .then((response) {
      if (response.statusCode == 200) {
        return NFTMarketplace(
            storeName: marketplaces[i],
            baseUri: getBaseUri(
                GenericJsonRpcResponse.fromJson(json.decode(response.body))),
            numberNfts: numberNfts[i]);
      } else {
        throw Exception('Failed to load NFTs');
      }
    }).catchError((error) {
      print(error);
      return NFTMarketplace(
          storeName: marketplaces[i], baseUri: "", numberNfts: 0);
    }));
  }
  List<NFTMarketplace> nftMarketplaces = await Future.wait(futures);
  return nftMarketplaces;
}

Future<List<int>> fetchNumberNFTAllConcurrent({
  required List<dynamic> marketplaces,
  required String accountId,
}) async {
  const methodName = "nft_supply_for_owner";
  var url = Uri.parse(RPC_URL);
  var args = {
    "account_id": accountId,
  };
  var argsBase64 = base64.encode(utf8.encode(json.encode(args)));
  print("argsBase64" + argsBase64);

  List<Future<int>> futures = [];
  for (var i = 0; i < marketplaces.length; i++) {
    var requestBody = getHttpBody(
        methodName: methodName,
        marketplace: marketplaces[i],
        argsBase64: argsBase64);

    futures.add(http
        .post(url, body: json.encode(requestBody), headers: HEADERS)
        .then((response) {
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        final GenericJsonRpcResponse generic =
            GenericJsonRpcResponse.fromJson(json.decode(response.body));
        print(decodeBufferIntForNumberNftOnAccount(
            bufferForDecode: generic.result.result));
        final dynamic inside = json.decode(json.encode(
            decodeBufferIntForNumberNftOnAccount(
                bufferForDecode: generic.result.result)));
        if (inside is int) {
          return inside;
        } else {
          return 0;
        }
      } else {
        return 0;
        // throw Exception('Failed to load NFTs');
      }
    }).catchError((error) {
      print(error);
      return 0;
    }));
  }
  List<int> number = await Future.wait(futures);
  return number;
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
    ArweaveRawMetadata generic = ArweaveRawMetadata.fromJson(response.data);
    print("GENERICGENERICGENERICGENERICGENERIC" + generic.toString());
    return generic;
  } else {
    throw Exception('Failed to load NFTs');
  }
}

int decodeBufferIntForNumberNftOnAccount(
        {required List<int> bufferForDecode}) =>
    int.parse(json.decode(utf8.decode(bufferForDecode)));

List<dynamic> decodeBuffer({required List<int> bufferForDecode}) {
  var bufferDecoded = utf8.decode(bufferForDecode);
  final List<dynamic> decoded = json.decode(bufferDecoded);
  return decoded;
}

List<String> getMarketplacesClean({required List<String> marketplaces}) {
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
    String argsBase64 = "e30=",
    String finality = "optimistic"}) {
  return {
    'jsonrpc': '2.0',
    'method': "query",
    "id": rng.nextInt(10000),
    'params': {
      "request_type": "call_function",
      "account_id": marketplace,
      "method_name": methodName,
      "args_base64": argsBase64,
      "finality": finality
    },
  };
}

bool isValidAccount(String accountID) {
  final String accountToValidate = accountID.replaceAll(" ", "");
  final bool contains = accountToValidate.contains(".near") ||
      accountToValidate.contains(".testnet");
  final bool validAccount = contains &&
          accountToValidate.indexOf(".near") == accountToValidate.length - 5 ||
      contains &&
          accountToValidate.indexOf(".testnet") == accountToValidate.length - 8;
  return validAccount;
}

bool isMainnet(String accountID) => !accountID.contains(".testnet");

String getBaseUri(GenericJsonRpcResponse raw) {
  var bufferForDecode = raw.result.result;
  var bufferDecoded = utf8.decode(bufferForDecode);
  final Map<String, dynamic> decoded = json.decode(bufferDecoded);
  final ResultNFTMarketData resultMarketData =
      ResultNFTMarketData.fromJson(decoded);
  return resultMarketData.baseUri;
}

List<MarketplacesWithNumberOfNFTs> getMarketplacesWithNfts(
    {required List<dynamic> nftMarketplaces, required List<int> numberNfts}) {
  List<MarketplacesWithNumberOfNFTs> marketplacesClean = [];
  List<String> marketplacesNotClean = [];
  for (var i = 0; i < nftMarketplaces.length; i++) {
    if (numberNfts[i] != 0) {
      marketplacesClean.add(MarketplacesWithNumberOfNFTs(
          marketplace: nftMarketplaces[i].toString(),
          numberNftFromMarketplace: numberNfts[i]));
    } else {
      marketplacesNotClean.add(nftMarketplaces[i].toString());
    }
  }
  print(marketplacesNotClean);
  return marketplacesClean;
}
