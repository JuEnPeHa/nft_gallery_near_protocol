part of 'nfts_bloc.dart';

abstract class NftsState extends Equatable {
  // NFT Account del que requerimos la información
  // NFT Account from which we require the information
  final String nearAccountID;
  // Si estamos en Mainnet o Testnet
  // If we are in Mainnet or Testnet
  final bool isMainnet;
  // Si la cuenta es válida
  // If the account is valid
  final bool validAccount;
  // Si estamos cargando
  // If we are charging
  final bool isCharging;
  // Total de NFTs
  // Total NFTs
  final int totalNftParas;

  // Contratos incluyendo spam
  // Contracts including spam
  final List<String> nftMarketplacesWithSpam;
  // Contratos sin spam (por ahora solo mintbase y paras)
  // Contracts without spam (for now only mintbase and paras)
  final List<String> nftMarketplacesChoosedMarketplaces;
  // Contratos limpios de spam (por ahora solo mintbase y paras) junto con el número de NFTs de cada contrato
  // Clean contracts without spam (for now only mintbase and paras) along with the number of NFTs of each contract
  final List<MarketplacesWithNumberOfNFTs> marketplacesCleanWithNumberOfNFTs;
  // final List<int> numberNfts; !todo: remove
  // NFTMarketplace { final String storeName; final String baseUri; final int numberNfts; } mapStoreWithBaseUri
  // Es como marketplacesClean pero con la clase NFTMarketplace y solo incluye los contratos con número de NFTs mayor a 0
  // It is like marketplacesClean but with the NFTMarketplace class and only includes contracts with number of NFTs greater than 0
  final List<NFTMarketplace> mapStoreWithBaseUri;
  // Lista de todos los NFTs de la cuenta
  // List of all the NFTs of the account
  final List<NftFinal> nfts;
  // final int id; !todo: remove

  const NftsState({
    required this.nearAccountID,
    required this.isMainnet,
    required this.validAccount,
    required this.isCharging,
    required this.totalNftParas,
    required this.nftMarketplacesWithSpam,
    required this.nftMarketplacesChoosedMarketplaces,
    required this.marketplacesCleanWithNumberOfNFTs,
    required this.mapStoreWithBaseUri,
    required this.nfts,
  });

  @override
  List<Object> get props => [
        nearAccountID,
        isMainnet,
        validAccount,
        isCharging,
        totalNftParas,
        nftMarketplacesWithSpam,
        nftMarketplacesChoosedMarketplaces,
        marketplacesCleanWithNumberOfNFTs,
        mapStoreWithBaseUri,
        nfts,
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
          nftMarketplacesChoosedMarketplaces: const [],
          marketplacesCleanWithNumberOfNFTs: const [],
          mapStoreWithBaseUri: const [],
          nfts: const [],
        );

  @override
  List<Object> get props => [
        nearAccountID,
        isMainnet,
        validAccount,
        isCharging,
        totalNftParas,
        nftMarketplacesWithSpam,
        nftMarketplacesChoosedMarketplaces,
        marketplacesCleanWithNumberOfNFTs,
        mapStoreWithBaseUri,
        nfts,
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
          nftMarketplacesChoosedMarketplaces: const [],
          marketplacesCleanWithNumberOfNFTs: const [],
          mapStoreWithBaseUri: const [],
          nfts: const [],
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
          nftMarketplacesChoosedMarketplaces: const [],
          marketplacesCleanWithNumberOfNFTs: const [],
          mapStoreWithBaseUri: const [],
          nfts: const [],
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
          nftMarketplacesChoosedMarketplaces: const [],
          marketplacesCleanWithNumberOfNFTs: const [],
          mapStoreWithBaseUri: const [],
          nfts: const [],
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
          nftMarketplacesChoosedMarketplaces: nftMarketplacesPreClean,
          marketplacesCleanWithNumberOfNFTs: const [],
          mapStoreWithBaseUri: const [],
          nfts: const [],
        );
}

class NftsMarketplacesCleanChargedState extends NftsState {
  const NftsMarketplacesCleanChargedState({
    required String nearAccountID,
    required bool isMainnet,
    required bool validAccount,
    required List<String> nftMarketplacesPreClean,
    required List<MarketplacesWithNumberOfNFTs> marketplacesClean,
  }) : super(
          nearAccountID: nearAccountID,
          isMainnet: isMainnet,
          validAccount: validAccount,
          isCharging: true,
          totalNftParas: 0,
          nftMarketplacesWithSpam: const [],
          nftMarketplacesChoosedMarketplaces: nftMarketplacesPreClean,
          marketplacesCleanWithNumberOfNFTs: marketplacesClean,
          mapStoreWithBaseUri: const [],
          nfts: const [],
        );
}

class NftsMarketPlacesChargedState extends NftsState {
  const NftsMarketPlacesChargedState({
    required String nearAccountID,
    required bool isMainnet,
    required bool validAccount,
    required List<String> nftMarketplacesWithSpam,
    required List<String> nftMarketplacesPreClean,
    required List<MarketplacesWithNumberOfNFTs> marketplacesClean,
    // required List<String> nftMarketplaces
  }) : super(
          nearAccountID: nearAccountID,
          isMainnet: isMainnet,
          validAccount: validAccount,
          isCharging: true,
          totalNftParas: 0,
          nftMarketplacesWithSpam: nftMarketplacesWithSpam,
          nftMarketplacesChoosedMarketplaces: nftMarketplacesPreClean,
          marketplacesCleanWithNumberOfNFTs: marketplacesClean,
          mapStoreWithBaseUri: const [],
          nfts: const [],
        );
}
