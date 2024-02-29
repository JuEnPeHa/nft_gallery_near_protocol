part of 'nfts_bloc.dart';

abstract class NftsEvent extends Equatable {
  const NftsEvent();

  @override
  List<Object> get props => [];
}

class NftsInitialEvent extends NftsEvent {
  const NftsInitialEvent();
}

class NftsSetAccountWithoutFetchEvent extends NftsEvent {
  final String nearAccountID;
  final bool isMainnet;
  final bool validAccount;

  const NftsSetAccountWithoutFetchEvent({
    required this.nearAccountID,
    required this.isMainnet,
    required this.validAccount,
  });
}

class NftsLoadingEvent extends NftsEvent {
  // final String nearAccountID;
  // final bool isMainnet;
  // final bool validAccount;

  const NftsLoadingEvent(
      //   {
      //   required this.nearAccountID,
      //   required this.isMainnet,
      //   required this.validAccount,
      // }
      );
}

class NftMarketplacesWithSpamEvent extends NftsEvent {
  final List<String> nftMarketplacesWithSpam;

  const NftMarketplacesWithSpamEvent({
    required this.nftMarketplacesWithSpam,
  });
}

// class NftMarketplacesPreCleanEvent extends NftsEvent {
//   final List<String> marketplacesPreClean;

//   const NftMarketplacesPreCleanEvent({
//     required this.marketplacesPreClean,
//   });
// }

class NftMarketplacesWithNumberEvent extends NftsEvent {
  final List<MarketplacesWithNumberOfNFTs> marketplacesChoosed;

  const NftMarketplacesWithNumberEvent({
    required this.marketplacesChoosed,
  });
}

class NftMarketplacesMapWithBaseUriEvent extends NftsEvent {
  final List<NFTMarketplace> mapStoreWithBaseUri;

  const NftMarketplacesMapWithBaseUriEvent({
    required this.mapStoreWithBaseUri,
  });
}

class NftsSetNftsEvent extends NftsEvent {
  final List<NFT> nfts;

  const NftsSetNftsEvent({
    required this.nfts,
  });
}