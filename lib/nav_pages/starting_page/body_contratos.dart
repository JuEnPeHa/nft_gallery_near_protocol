import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nft_gallery/providers/bloc/nfts_bloc.dart';
import 'package:nft_gallery/widgets/neumor.dart';
import 'package:shimmer/shimmer.dart';

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
              if (state is NftsInitialState) const ShimmerInitialText(),
              if (state is NftsLoadingState) const ShimmerLoadingList(),
              state.nftMarketplacesWithSpam.isEmpty
                  ? const SizedBox()
                  : Center(
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
                                      child: Center(
                                        child: Text(item),
                                      )),
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

class ShimmerLoadingList extends StatelessWidget {
  const ShimmerLoadingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: NeumorConverter(
        principalColor: Colors.grey,
        padding: 2,
        margin: 10,
        child: SizedBox(
          height: 20,
          width: MediaQuery.of(context).size.width * 0.9,
        ),
      ),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.grey,
          Colors.white,
          Colors.grey,
        ],
      ),
    );
  }
}

class ShimmerInitialText extends StatelessWidget {
  const ShimmerInitialText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Text(
        'Ingrese su cuenta NEAR para ver los detalles.',
      ),
    );
  }
}
