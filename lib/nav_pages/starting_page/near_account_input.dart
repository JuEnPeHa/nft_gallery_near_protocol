import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nft_gallery/models/nft_marketplace.dart';
import 'package:nft_gallery/nav_pages/starting_page/dialogs_invalid_account_store_dialog.dart';
import 'package:nft_gallery/providers/bloc/bloc_update_functions.dart';
import 'package:nft_gallery/providers/bloc/nfts_bloc.dart';
import 'package:nft_gallery/utils/rpc_functions.dart';

class NearAccountInput extends StatefulWidget {
  const NearAccountInput({Key? key}) : super(key: key);

  @override
  State<NearAccountInput> createState() => _NearAccountInputState();
}

class _NearAccountInputState extends State<NearAccountInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.075),
      child: BlocBuilder<NftsBloc, NftsState>(
        buildWhen: (previous, current) =>
            previous.validAccount != current.validAccount,
        builder: (context, state) {
          return TextField(
            // focusNode: _focusNode,
            controller: _controller,
            style: TextStyle(
              fontSize: 18,
              color: state.validAccount ? Colors.green : Colors.red,
            ),
            autocorrect: false,
            textInputAction: TextInputAction.send,
            autofocus: false,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              labelText: 'Account',
              prefixIcon: const Icon(Icons.account_circle),
            ),
            onChanged: (value) {
              // setState(() {
              //   validAccount = isValidAccount(value);
              //   if (validAccount) {
              //     nearAccountId = value;
              //   }
              // });
              setAccountWithoutFetch(
                nearAccountId: value,
                context: context,
              );
            },
            onSubmitted: (_) {
              // _submit();
              state.validAccount && !state.isCharging
                  ? {
                      //unfocus
                      FocusScope.of(context).unfocus(),
                      fetchAll(
                        nearAccountId: _controller.text,
                        context: context,
                      ),
                      _controller.clear(),
                    }
                  : null;
            },
          );
        },
      ),
    );
  }
}

class TextoIngresarNEARAccount extends StatelessWidget {
  const TextoIngresarNEARAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: const Text(
        "Por favor ingresa tu NEAR account",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}

void fetchAll(
    {required String nearAccountId, required BuildContext context}) async {
  // Establecer el estado de carga
  // We set the loading state
  setLoading(nearAccountId: nearAccountId, context: context);
  // Pedimos los likelyNfts (Los contratos qué han iniciado un evento de transferencia)
  // We ask for the likelyNfts (The contracts that have started a transfer event)
  final List<String> nftMarketplacesFromHelperWithSpam =
      await fetchNFTMarketplaces(nearAccountId, isMainnet(nearAccountId));
  log('fetchAll nftMarketplacesFromHelper: ' +
      nftMarketplacesFromHelperWithSpam.toString());
  // Si no hay contratos, mostramos un dialogo de cuenta inválida
  // If there are no contracts, we show an invalid account dialog
  if (nftMarketplacesFromHelperWithSpam.isEmpty) {
    showInvalidAccountDialog(context);
  }
  // Establecemos los contratos incluyendo los spam
  // We set the contracts including the spam
  setNftMarketplacesWithSpam(
    nftMarketplacesWithSpam: nftMarketplacesFromHelperWithSpam,
    context: context,
  );
  // Limpiamos los contratos de spam, dejando por ahora los que incluyen mintbase y paras
  // We clean the contracts of spam, leaving for now those that include mintbase and paras
  final List<String> nftMarketplacesPreClean =
      getMarketplacesClean(marketplaces: nftMarketplacesFromHelperWithSpam);
  // Establecemos los contratos limpios de spam (por ahora solo mintbase y paras)
  // We set the clean contracts without spam (for now only mintbase and paras)
  setMarketplacesPreClean(
    marketplacesPreClean: nftMarketplacesPreClean,
    context: context,
  );
  // Pedimos el número de NFTs por contrato del usuario
  // We ask for the number of NFTs per contract of the user
  final List<int> numberOfNftsPerMarketplace =
      await fetchNumberNFTAllConcurrent(
    marketplaces: nftMarketplacesPreClean,
    accountId: nearAccountId,
  );
  print('numberOfNftsPerMarketplace: ' + numberOfNftsPerMarketplace.toString());
  // Establecemos los contratos con número de NFTs mayor a 0 y los ubicamos en un mapa {contrato: número de NFTs}
  // We set the contracts with number of NFTs greater than 0 and place them in a map {contract: number of NFTs}
  setNftMarketplacesClean(
    nftMarketplacesClean: nftMarketplacesPreClean,
    context: context,
  );
  // Pedimos las imágenes de los contratos (No los NFTs en sí, sino las imágenes de los contratos) y pedimos la baseUrl de los contratos
  // We ask for the images of the contracts (Not the NFTs themselves, but the images of the contracts) and we ask for the baseUrl of the contracts
  final List<NFTMarketplace> nftMarketplacesClean =
      await fetchNFTMarketPlaceImagesConcurrent(
    marketplaces: nftMarketplacesPreClean,
    numberNfts: numberOfNftsPerMarketplace,
  );
  log('fetchAll nftMarketplacesClean: ' + nftMarketplacesClean.toString());
  // Establecemos las imágenes de los contratos, la baseUrl de los contratos y el número de NFTs por contrato cada uno con la clase NFTMarketplace
  // We set the images of the contracts, the baseUrl of the contracts and the number of NFTs per contract each with the NFTMarketplace class
  setNftMarketplaces(
    nftMarketplaces: nftMarketplacesClean,
    context: context,
  );
}
