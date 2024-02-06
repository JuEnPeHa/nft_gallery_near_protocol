part of 'nfts_bloc.dart';

abstract class NftsState extends Equatable {
  final String nearAccountID;
  final bool isMainnet;
  final bool validAccount;
  final bool isCharging;
  final int totalNftParas;

  final List<dynamic> nftMarketplaces;
  final List<dynamic> nftMarketplacesPreClean;
  final List<MarketplacesClean> marketplacesClean;
  final List<int> numberNfts;
  final List<NFTMarketplace> mapStoreWithBaseUri;
  final List<NftFinal> nfts;
  final int id;

  const NftsState({
    this.nearAccountID = '',
    this.isMainnet = false,
    this.validAccount = false,
    this.isCharging = false,
    this.totalNftParas = 0,
    this.nftMarketplaces = const [],
    this.nftMarketplacesPreClean = const [],
    this.marketplacesClean = const [],
    this.numberNfts = const [],
    this.mapStoreWithBaseUri = const [],
    this.nfts = const [],
    this.id = 0,
  });

  @override
  List<Object> get props => [];
}

class NftsInitialState extends NftsState {}
