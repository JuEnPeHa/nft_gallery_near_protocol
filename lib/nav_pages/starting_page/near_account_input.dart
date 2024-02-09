import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nft_gallery/nav_pages/starting_page/dialogs_invalid_account_store_dialog.dart';
import 'package:nft_gallery/providers/bloc/bloc_update_functions.dart';
import 'package:nft_gallery/providers/bloc/nfts_bloc.dart';
import 'package:nft_gallery/utils/rpcFunctions.dart';

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
    return Container(
      child: const Text(
        "Por favor ingresa tu NEAR account",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}

void fetchAll(
    {required String nearAccountId, required BuildContext context}) async {
  setLoading(nearAccountId: nearAccountId, context: context);
  final List<String> nftMarketplacesFromHelperWithSpam =
      await fetchNFTMarketplaces(nearAccountId, isMainnet(nearAccountId));
  log('fetchAll nftMarketplacesFromHelper: ' +
      nftMarketplacesFromHelperWithSpam.toString());
  if (nftMarketplacesFromHelperWithSpam.isEmpty) {
    showInvalidAccountDialog(context);
  }
  setNftMarketplacesWithSpam(
    nftMarketplacesWithSpam: nftMarketplacesFromHelperWithSpam,
    context: context,
  );
  final List<String> nftMarketplacesPreClean =
      getMarketplacesClean(marketplaces: nftMarketplacesFromHelperWithSpam);
  setMarketplacesPreClean(
    marketplacesPreClean: nftMarketplacesPreClean,
    context: context,
  );
  final List<int> numberOfNftsPerMarketplace =
      await fetchNumberNFTAllConcurrent(
    marketplaces: nftMarketplacesPreClean,
    accountId: nearAccountId,
  );
  print('numberOfNftsPerMarketplace: ' + numberOfNftsPerMarketplace.toString());
}
