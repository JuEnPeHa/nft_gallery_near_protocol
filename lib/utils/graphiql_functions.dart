// /*
// This is an example snippet - you should consider tailoring it
// to your service.
// */

// async function fetchGraphQL(operationsDoc, operationName, variables) {
//   const result = await fetch(
//     "https://graph.mintbase.xyz/mainnet",
//     {
//       method: "POST",
//       body: JSON.stringify({
//         query: operationsDoc,
//         variables: variables,
//         operationName: operationName
//       })
//     }
//   );

//   return await result.json();
// }

// const operationsDoc = `
//   query MyQuery {
//     mb_views_nft_metadata(distinct_on: nft_contract_id) {
//       nft_contract {
//         id
//       }
//     }
//   }
// `;

// function fetchMyQuery() {
//   return fetchGraphQL(
//     operationsDoc,
//     "MyQuery",
//     {}
//   );
// }

// async function startFetchMyQuery() {
//   const { errors, data } = await fetchMyQuery();

//   if (errors) {
//     // handle those errors like a pro
//     console.error(errors);
//   }

//   // do something great with this precious data
//   console.log(data);
// }

// startFetchMyQuery();

// Now changing to Dart code.

//import http
//import dart:convert
// import 'dart:convert';

// import 'package:http/http.dart' as http;

// String operationsDoc = '''
//   query MyQuery {
//     mb_views_nft_metadata(distinct_on: nft_contract_id) {
//       nft_contract {
//         id
//       }
//     }
//   }
// ''';

// Future<List<String>> listOfAllNftContracts(
//     String aID, String operationsDoc, String operationName) async {
//   return await fetchMyQuery(aID, operationsDoc, operationName);
// }

// Future<List<String>> fetchMyQuery(
//     String aID, String operationsDoc, String operationName) async {
//   return await fetchGraphQL(aID, operationsDoc, operationName);
// }

// Future<List<String>> fetchGraphQL(
//     String aID, String operationsDoc, String operationName) async {
//   final http.Response response = await http.post(
//     Uri.parse("https://graph.mintbase.xyz/mainnet"),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//       'mb-api-key': 'anon'
//     },
//     body: jsonEncode(<String, Object>{
//       'query': operationsDoc,
//       'variables': aID,
//       'operationName': operationName
//     }),
//   );

//   print(response.body);
//   if (response.statusCode == 200) {
//     print(jsonDecode(response.body));
//     return jsonDecode(response.body);
//   } else {
//     throw Exception('Failed to load data');
//   }
// }
