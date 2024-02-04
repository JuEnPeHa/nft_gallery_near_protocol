import 'package:nft_gallery/constants.dart';
import 'package:nft_gallery/hive_models/hive_data.dart';
import 'package:nft_gallery/models/arweaveRawMetadata.dart';
import 'package:nft_gallery/models/listNFTParas.dart';
import 'package:nft_gallery/models/nft.dart';
import 'package:nft_gallery/models/nft_marketplace.dart';
import 'package:nft_gallery/models/resultNFTMetadataMintbase.dart';
import 'package:nft_gallery/models/resultNFTMetadataParas.dart';
import 'package:nft_gallery/main_screens.dart';
import 'package:nft_gallery/widgets/neumor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:nft_gallery/utils/rpcFunctions.dart';

class CuartaPage extends StatefulWidget {
  const CuartaPage({Key? key}) : super(key: key);

  @override
  _CuartaPageState createState() => _CuartaPageState();
}

class _CuartaPageState extends State<CuartaPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final HiveData hiveData = const HiveData();

  _submit() {
    isCharging = true;
    final String value = _controller.text;
    if (value.isEmpty || value.length <= 5 || !validAccount) {
      return showCupertinoDialog(
          context: context,
          builder: (context) {
            return AlertDialog.adaptive(
              title: const Text('Invalid account'),
              content: const Text('Please enter a valid account'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: const Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          });
    }
    nearAccountId = value;
    fetchAll();
    _controller.clear();
    _focusNode.unfocus();
    // setState(() {
    //   hiveData.add(value);
    // });
  }

  _clear() {
    _controller.clear();
    _focusNode.unfocus();
    nftMarketplaces.clear();
    nfts.clear();
    mapStoreWithBaseUri.clear();
    nftMarketplacesPreClean.clear();
    numberNfts.clear();
    id = 0;
    nearAccountId = '';
    totalNftParas = 0;
    setState(() {});
  }

  int totalNftParas = 0;
  late bool mainnet;
  bool allDataComplete = false;
  bool validAccount = false;
  List<dynamic> nftMarketplaces = [];
  List<dynamic> nftMarketplacesPreClean = [];
  List<MarketplacesClean> marketplacesClean = [];
  List<int> numberNfts = [];
  List<NFTMarketplace> mapStoreWithBaseUri = [];
  List<NftFinal> nfts = [];
  int id = 0;
  bool isCharging = false;
  String nearAccountId = "";

  void fetchAll() async {
    mainnet = isMainnet(nearAccountId);
    fetchNFTMarketplaces(nearAccountId, mainnet).then((value) {
      nftMarketplaces.addAll(value);
      nftMarketplacesPreClean
          .addAll(getMarketplacesClean(marketplaces: nftMarketplaces));
      print(nftMarketplacesPreClean);
      setState(() {});
      fetchNumberNFTAll(
              marketplaces: nftMarketplacesPreClean, accountId: nearAccountId)
          .then((value) {
        //totalNftParas = value;
        numberNfts.addAll(value);
        print("TOTALNFTPARASTOTALNFTPARAS" + numberNfts.toString());
        marketplacesClean.addAll(getMarketplacesWithNfts(
            nftMarketplaces: nftMarketplacesPreClean, numberNfts: numberNfts));
        nftMarketplacesPreClean.clear();
        numberNfts.clear();
        for (var item in marketplacesClean) {
          nftMarketplacesPreClean.add(item.marketplace);
          numberNfts.add(item.numberNftFromMarketplace);
          if (item.marketplace.contains('paras')) {
            totalNftParas += item.numberNftFromMarketplace;
          }
        }
        setState(() {});
        fetchNFTMarketPlaceImages(
                marketplaces: nftMarketplacesPreClean, numberNfts: numberNfts)
            .then((value) {
          mapStoreWithBaseUri = value;
          setState(() {});
          fetchNFTMetadataAll(accountId: nearAccountId, marketplaces: value)
              .then((value) {
            id++;
            print(nfts.length + nftMarketplaces.length);
            setState(() {
              nfts.addAll(value);
              isCharging = false;
              print("EEEEEEEEEEEEEEEEEEEEE" + nfts.toString());
              allDataComplete = true;
            });
          });
        });
        return value;
      });
      return value;
    });
  }

  @override
  initState() {
    //isCharging = true;
    super.initState();
    //fetchAll();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('NFT Gallery'),
            nearAccountId == null
                ? Text('')
                : Text(
                    'Account: ' + nearAccountId,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
            const SizedBox(),
          ]),
          elevation: 10,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color(0xFFFF5252),
                  Color(0xFF448AFF),
                ],
              ),
            ),
          ),
        ),
        //drawer: const Drawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
              Container(
                child: const Text(
                  "Por favor ingresa tu NEAR account",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.075),
                child: TextField(
                  focusNode: _focusNode,
                  controller: _controller,
                  style: TextStyle(
                      fontSize: 18,
                      color: validAccount ? Colors.green : Colors.red),
                  autocorrect: false,
                  textInputAction: TextInputAction.send,
                  autofocus: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Account',
                    prefixIcon: const Icon(Icons.account_circle),
                  ),
                  onChanged: (value) {
                    setState(() {
                      validAccount = isValidAccount(value);
                      if (validAccount) {
                        nearAccountId = value;
                      }
                    });
                  },
                  onSubmitted: (value) {
                    _submit();
                  },
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                children: [
                  NeumorConverter(
                      principalColor: Colors.grey,
                      padding: 2,
                      child: CupertinoButton(
                          child: const Text("Submit"),
                          onPressed: () => _submit())),
                  NeumorConverter(
                      principalColor: Colors.grey,
                      padding: 2,
                      child: CupertinoButton(
                          child: const Text("Clear"),
                          onPressed: () => _clear())),
                ],
              ),
              SizedBox(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      "Contratos:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      height: 15,
                    ),
                    nftMarketplaces.isEmpty
                        ? SizedBox()
                        : isCharging
                            ? const CircularProgressIndicator()
                            : Center(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ...nftMarketplaces.map((item) {
                                        return Column(
                                          children: [
                                            NeumorConverter(
                                              principalColor: Colors.grey,
                                              padding: 2,
                                              child: Center(
                                                child: Padding(
                                                    padding: EdgeInsets.all(5),
                                                    child: Center(
                                                        child: Text(item))),
                                              ),
                                            ),
                                            const Divider(height: 15),
                                          ],
                                        );
                                      }),
                                    ]),
                              ),
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  children: [
                    const Text(
                      "Marketplaces:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      height: 15,
                    ),
                    mapStoreWithBaseUri.isEmpty
                        ? SizedBox()
                        : isCharging
                            ? const CircularProgressIndicator()
                            : Column(children: [
                                ...mapStoreWithBaseUri.map((item) {
                                  return Column(
                                    children: [
                                      NeumorConverter(
                                        principalColor: Colors.grey,
                                        padding: 2,
                                        child: Center(
                                          child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Center(
                                                  child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      showCupertinoDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              CupertinoAlertDialog(
                                                                title:
                                                                    const Text(
                                                                        "Store"),
                                                                content: Column(
                                                                  children: [
                                                                    Text(item
                                                                        .storeName),
                                                                    Text(
                                                                        "Tienes ${item.numberNfts} NFTs"),
                                                                  ],
                                                                ),
                                                                actions: [
                                                                  CupertinoDialogAction(
                                                                    child: const Text(
                                                                        "Cerrar"),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  ),
                                                                ],
                                                              ));
                                                    },
                                                    icon: const Icon(
                                                      Icons.quiz,
                                                      color: Colors.green,
                                                      size: 35,
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(item.storeName,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      15)),
                                                      Text(item.baseUri,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 15))
                                                    ],
                                                  ),
                                                  Text(
                                                      item.numberNfts
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 20)),
                                                ],
                                              ))),
                                        ),
                                      ),
                                      const Divider(height: 15),
                                    ],
                                  );
                                }),
                              ]),
                  ],
                ),
              ),
              SizedBox(
                child: GridView.count(
                  scrollDirection: Axis.vertical,
                  addAutomaticKeepAlives: true,
                  cacheExtent: 5000,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: [
                    ...nfts.map((e) {
                      return CachedNetworkImage(
                          imageUrl: e.principalImageUrl +
                              '?w=600&auto=format,compress');
                    })
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton(
          onPressed: allDataComplete
              ? () async {
                  await hiveData.saveNfts(nfts).then((value) =>
                      Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                              builder: ((context) => const MainScreens()))));
                }
              : null,
          child: allDataComplete && nfts.isNotEmpty
              ? const Icon(
                  Icons.done,
                  color: Colors.green,
                )
              : const CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.red),
          backgroundColor: allDataComplete ? Colors.indigo : Colors.grey,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        // bottomNavigationBar: BottomNavigationBar(
        //   items: const [
        //     BottomNavigationBarItem(icon: Icon(Icons.abc), label: "Hey"),
        //     BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "Hola")
        //   ],
        // ),
      ),
    );
  }
}
