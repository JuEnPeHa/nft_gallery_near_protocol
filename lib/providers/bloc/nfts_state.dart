part of 'nfts_bloc.dart';

abstract class NftsState extends Equatable {
  final String nearAccountID;
  final bool isMainnet;
  final bool validAccount;
  final bool isCharging;
  final int totalNftParas;

  final List<String> nftMarketplacesWithSpam;
  final List<String> nftMarketplacesPreClean;
  final List<MarketplacesClean> marketplacesClean;
  final List<int> numberNfts;
  final List<NFTMarketplace> mapStoreWithBaseUri;
  final List<NftFinal> nfts;
  final int id;

  const NftsState({
    required this.nearAccountID,
    required this.isMainnet,
    required this.validAccount,
    required this.isCharging,
    required this.totalNftParas,
    required this.nftMarketplacesWithSpam,
    required this.nftMarketplacesPreClean,
    required this.marketplacesClean,
    required this.numberNfts,
    required this.mapStoreWithBaseUri,
    required this.nfts,
    required this.id,
  });

  @override
  List<Object> get props => [
        nearAccountID,
        isMainnet,
        validAccount,
        isCharging,
        totalNftParas,
        nftMarketplacesWithSpam,
        nftMarketplacesPreClean,
        marketplacesClean,
        numberNfts,
        mapStoreWithBaseUri,
        nfts,
        id,
      ];
}

class NftsInitialState extends NftsState {
  const NftsInitialState()
      : super(
          nearAccountID: '',
          isMainnet: false,
          validAccount: false,
          isCharging: false,
          totalNftParas: 0,
          nftMarketplacesWithSpam: const [],
          nftMarketplacesPreClean: const [],
          marketplacesClean: const [],
          numberNfts: const [],
          mapStoreWithBaseUri: const [],
          nfts: const [],
          id: 0,
        );

  @override
  List<Object> get props => [
        nearAccountID,
        isMainnet,
        validAccount,
        isCharging,
        totalNftParas,
        nftMarketplacesWithSpam,
        nftMarketplacesPreClean,
        marketplacesClean,
        numberNfts,
        mapStoreWithBaseUri,
        nfts,
        id,
      ];
}

class NftsSetAccountWithoutFetchChargedState extends NftsState {
  const NftsSetAccountWithoutFetchChargedState({
    required String nearAccountID,
    required bool isMainnet,
    required bool validAccount,
  }) : super(
          nearAccountID: nearAccountID,
          isMainnet: isMainnet,
          validAccount: validAccount,
          isCharging: false,
          totalNftParas: 0,
          nftMarketplacesWithSpam: const [],
          nftMarketplacesPreClean: const [],
          marketplacesClean: const [],
          numberNfts: const [],
          mapStoreWithBaseUri: const [],
          nfts: const [],
          id: 0,
        );
}

class NftsLoadingState extends NftsState {
  const NftsLoadingState({
    required String nearAccountID,
    required bool isMainnet,
    required bool validAccount,
  }) : super(
          nearAccountID: nearAccountID,
          isMainnet: isMainnet,
          validAccount: validAccount,
          isCharging: true,
          totalNftParas: 0,
          nftMarketplacesWithSpam: const [],
          nftMarketplacesPreClean: const [],
          marketplacesClean: const [],
          numberNfts: const [],
          mapStoreWithBaseUri: const [],
          nfts: const [],
          id: 0,
        );
}

class NftsMarketplacesWithSpamChargedState extends NftsState {
  const NftsMarketplacesWithSpamChargedState({
    required String nearAccountID,
    required bool isMainnet,
    required bool validAccount,
    required List<String> nftMarketplacesWithSpam,
  }) : super(
          nearAccountID: nearAccountID,
          isMainnet: isMainnet,
          validAccount: validAccount,
          isCharging: true,
          totalNftParas: 0,
          nftMarketplacesWithSpam: nftMarketplacesWithSpam,
          nftMarketplacesPreClean: const [],
          marketplacesClean: const [],
          numberNfts: const [],
          mapStoreWithBaseUri: const [],
          nfts: const [],
          id: 0,
        );
}

class NftsMarketplacesPreCleanChargedState extends NftsState {
  const NftsMarketplacesPreCleanChargedState({
    required String nearAccountID,
    required bool isMainnet,
    required bool validAccount,
    required List<String> nftMarketplacesWithSpam,
    required List<String> nftMarketplacesPreClean,
  }) : super(
          nearAccountID: nearAccountID,
          isMainnet: isMainnet,
          validAccount: validAccount,
          isCharging: true,
          totalNftParas: 0,
          nftMarketplacesWithSpam: nftMarketplacesWithSpam,
          nftMarketplacesPreClean: nftMarketplacesPreClean,
          marketplacesClean: const [],
          numberNfts: const [],
          mapStoreWithBaseUri: const [],
          nfts: const [],
          id: 0,
        );
}

class NftsMarketplacesCleanChargedState extends NftsState {
  const NftsMarketplacesCleanChargedState({
    required String nearAccountID,
    required bool isMainnet,
    required bool validAccount,
    required List<String> nftMarketplacesPreClean,
    required List<MarketplacesClean> marketplacesClean,
  }) : super(
          nearAccountID: nearAccountID,
          isMainnet: isMainnet,
          validAccount: validAccount,
          isCharging: true,
          totalNftParas: 0,
          nftMarketplacesWithSpam: const [],
          nftMarketplacesPreClean: nftMarketplacesPreClean,
          marketplacesClean: marketplacesClean,
          numberNfts: const [],
          mapStoreWithBaseUri: const [],
          nfts: const [],
          id: 0,
        );
}

class NftsMarketPlacesChargedState extends NftsState {
  const NftsMarketPlacesChargedState({
    required String nearAccountID,
    required bool isMainnet,
    required bool validAccount,
    required List<String> nftMarketplacesWithSpam,
    required List<String> nftMarketplacesPreClean,
    required List<MarketplacesClean> marketplacesClean,
    // required List<String> nftMarketplaces
  }) : super(
          nearAccountID: nearAccountID,
          isMainnet: isMainnet,
          validAccount: validAccount,
          isCharging: true,
          totalNftParas: 0,
          nftMarketplacesWithSpam: nftMarketplacesWithSpam,
          nftMarketplacesPreClean: nftMarketplacesPreClean,
          marketplacesClean: marketplacesClean,
          numberNfts: const [],
          mapStoreWithBaseUri: const [],
          nfts: const [],
          id: 0,
        );
}
