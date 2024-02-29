// NftsBloc

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nft_gallery/providers/bloc/nfts_bloc.dart';
import 'package:nft_gallery/utils/rpc_functions.dart';

void setAccountWithoutFetch(
    {required String nearAccountId, required BuildContext context}) {
  final bool mainnet = isMainnet(nearAccountId);
  final bool validAccount = isValidAccount(nearAccountId);
  BlocProvider.of<NftsBloc>(context).add(
    NftsSetAccountWithoutFetchEvent(
      nearAccountID: nearAccountId,
      isMainnet: mainnet,
      validAccount: validAccount,
    ),
  );
}

void setLoading(
    {required String nearAccountId, required BuildContext context}) {
  final bool mainnet = isMainnet(nearAccountId);
  final bool validAccount = isValidAccount(nearAccountId);
  BlocProvider.of<NftsBloc>(context).add(
    NftsLoadingEvent(
      nearAccountID: nearAccountId,
      isMainnet: mainnet,
      validAccount: validAccount,
    ),
  );
}

void setInitial(BuildContext context) {
  BlocProvider.of<NftsBloc>(context).add(
    NftsInitialEvent(),
  );
}

void setNftMarketplacesWithSpam({
  required List<String> nftMarketplacesWithSpam,
  required BuildContext context,
}) {
  BlocProvider.of<NftsBloc>(context).add(
    NftMarketplacesWithSpamEvent(
      nftMarketplacesWithSpam: nftMarketplacesWithSpam,
    ),
  );
}

void setMarketplacesPreClean({
  required List<String> marketplacesPreClean,
  required BuildContext context,
}) {
  BlocProvider.of<NftsBloc>(context).add(
    NftMarketplacesPreCleanEvent(
      marketplacesPreClean: marketplacesPreClean,
    ),
  );
}

void setNftMarketplacesClean({
  required List<String> nftMarketplacesClean,
  required BuildContext context,
}) {
  BlocProvider.of<NftsBloc>(context).add(
    NftMarketplacesCleanEvent(
      marketplacesClean: nftMarketplacesClean,
    ),
  );
}
