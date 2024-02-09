import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nft_gallery/models/nft_marketplace.dart';
import 'package:nft_gallery/providers/bloc/bloc_update_functions.dart';

void showInvalidAccountDialog(BuildContext context) {
  showCupertinoDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: const Text('Invalid account'),
          content: const Text('Please enter a valid account'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('OK'),
              // onPressed: () => Navigator.of(context).pop(),
              onPressed: () {
                setInitial(context);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

void showStoreDialog(BuildContext context, NFTMarketplace item) {
  showCupertinoDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
            title: const Text("Store"),
            content: Column(
              children: [
                Text(item.storeName),
                Text("Tienes ${item.numberNfts} NFTs"),
              ],
            ),
            actions: [
              CupertinoDialogAction(
                child: const Text("Cerrar"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ));
}
