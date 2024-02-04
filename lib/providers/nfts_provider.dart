import 'package:flutter/material.dart';
import 'package:nft_gallery/cuarta_page.dart';
import 'package:nft_gallery/hive_models/hive_data.dart';
import 'package:nft_gallery/main_screens.dart';
import 'package:nft_gallery/models/nft.dart';

class NftsProvider extends ChangeNotifier {
  bool isInit = false;

  final HiveData hiveData = const HiveData();
  List<NftFinal> nfts = [];

  Future<void> _initHive() async {
    nfts = await hiveData.nfts;
    isInit = true;
    notifyListeners();
  }

  Future<void> initState(BuildContext context) async {
    await _initHive();
    _changePage(context, isInit, nfts.isEmpty);
  }

  void _changePage(BuildContext context, bool isInit, bool isEmpty) {
    if (isInit) {
      if (isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const CuartaPage()));
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const MainScreens()));
        });
      }
    }
  }
}

    //             if (nftsProvider.nfts.isEmpty) {
    //               WidgetsBinding.instance.addPostFrameCallback((_) {
    //                 Navigator.pushReplacement(
    //                     context,
    //                     MaterialPageRoute(
    //                         builder: (context) => const CuartaPage()));
    //               });
    //             } else {
    //               WidgetsBinding.instance.addPostFrameCallback((_) {
    //                 Navigator.pushReplacement(
    //                     context,
    //                     MaterialPageRoute(
    //                         builder: (context) => const MainScreens()));
    //               });
    //             }