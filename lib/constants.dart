//NEAR  Protocol
import 'dart:convert';

final String nearProtocol = 'https://near.org/';
final String ACCOUNT_HELPER_URL = 'https://helper.mainnet.near.org';
final String ACCOUNT_HELPER_URL_TESTNET = 'https://helper.testnet.near.org';
final String RPC_URL = 'https://rpc.mainnet.near.org';
final String ACCOUNT_ID = 'jeph.near';
final String EXPLORE_APPS_URL = "https://awesomenear.com/trending/";
final String EXPLORE_DEFI_URL = "https://awesomenear.com/categories/defi/";
final String EXPLORER_URL = "https://explorer.mainnet.near.org";
final String ACCOUNT_ID_SUFFIX = "near";
final String NETWORK_ID = "default";
final String NODE_URL = "https://rpc.mainnet.near.org";
var HEADERS = {'Content-type': 'application/json; charset=utf-8'};

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
