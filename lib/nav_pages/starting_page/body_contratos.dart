import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nft_gallery/providers/bloc/nfts_bloc.dart';
import 'package:nft_gallery/widgets/neumor.dart';

class BodyContratos extends StatelessWidget {
  const BodyContratos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BlocBuilder<NftsBloc, NftsState>(
        buildWhen: (previous, current) =>
            previous.marketplacesClean != current.marketplacesClean ||
            previous.isCharging != current.isCharging ||
            previous.nftMarketplacesWithSpam !=
                current.nftMarketplacesWithSpam ||
            previous.nearAccountID != current.nearAccountID ||
            previous.validAccount != current.validAccount ||
            previous.isMainnet != current.isMainnet ||
            previous.nftMarketplacesPreClean != current.nftMarketplacesPreClean,
        builder: (context, state) {
          print('BodyContratos build: ' +
              state.nftMarketplacesWithSpam.toString());
          return Column(
            children: [
              const SizedBox(height: 10),
              const Text(
                "Contratos:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Divider(
                height: 15,
              ),
              state.nftMarketplacesWithSpam.isEmpty
                  ? SizedBox()
                  :
                  //  state.isCharging
                  //     ? const CircularProgressIndicator()
                  //     :
                  Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...state.nftMarketplacesWithSpam.map((item) {
                              return NeumorConverter(
                                principalColor: Colors.grey,
                                padding: 2,
                                margin: 10,
                                child: Center(
                                  child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Center(child: Text(item))),
                                ),
                              );
                            }),
                          ]),
                    ),
            ],
          );
        },
      ),
    );
  }
}
