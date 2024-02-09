import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nft_gallery/nav_pages/starting_page/dialogs_invalid_account_store_dialog.dart';
import 'package:nft_gallery/providers/bloc/nfts_bloc.dart';
import 'package:nft_gallery/widgets/neumor.dart';

class BodyMarketplaces extends StatelessWidget {
  const BodyMarketplaces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BlocBuilder<NftsBloc, NftsState>(
        builder: (context, state) {
          return Column(
            children: [
              const Text(
                "Marketplaces:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Divider(
                height: 15,
              ),
              state.mapStoreWithBaseUri.isEmpty
                  ? SizedBox()
                  : state.isCharging
                      ? const CircularProgressIndicator()
                      : Column(children: [
                          ...state.mapStoreWithBaseUri.map((item) {
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
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                showStoreDialog(context, item);
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
                                                    style: const TextStyle(
                                                        fontSize: 15)),
                                                Text(item.baseUri,
                                                    style: const TextStyle(
                                                        fontSize: 15))
                                              ],
                                            ),
                                            Text(item.numberNfts.toString(),
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
          );
        },
      ),
    );
  }
}
