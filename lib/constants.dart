//NEAR  Protocol
import 'dart:convert';

const String nearProtocol = 'https://near.org/';
const String ACCOUNT_HELPER_URL = 'https://api.kitwallet.app';
const String ACCOUNT_HELPER_URL_TESTNET = 'https://testnet-api.kitwallet.app';
const String RPC_URL = 'https://rpc.mainnet.near.org';
const String ACCOUNT_ID = 'jeph.near';
const String EXPLORE_APPS_URL = "https://awesomenear.com/trending/";
const String EXPLORE_DEFI_URL = "https://awesomenear.com/categories/defi/";
const String EXPLORER_URL = "https://explorer.mainnet.near.org";
const String ACCOUNT_ID_SUFFIX = "near";
const String NETWORK_ID = "default";
const String NODE_URL = "https://rpc.mainnet.near.org";
const Map<String, String> HEADERS = {'Content-type': 'application/json; charset=utf-8'};

String accountID = "jeph.near";

String resolveMarketplaceData(dynamic data) {
  if (data is List<int>) {
    String result = utf8.decode(data);
    return result;
  } else if (data is String) {
    return data.codeUnits.toString();
  } else {
    throw Exception('Unknown type');
  }
}
