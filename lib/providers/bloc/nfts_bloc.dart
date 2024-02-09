import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nft_gallery/models/nft.dart';
import 'package:nft_gallery/models/nft_marketplace.dart';

part 'nfts_event.dart';
part 'nfts_state.dart';

class NftsBloc extends Bloc<NftsEvent, NftsState> {
  NftsBloc() : super(const NftsInitialState()) {
    void _onNftsInitialEvent(NftsInitialEvent event, Emitter<NftsState> emit) {
      log('NftsInitialEvent' + DateTime.now().toString());
      emit(const NftsInitialState());
    }

    void _onSetNftMarketplacesWithSpamEvent(
        NftMarketplacesWithSpamEvent event, Emitter<NftsState> emit) {
      log('NftMarketplacesWithSpamEvent' + DateTime.now().toString());
      print('NftMarketplacesWithSpamState' +
          event.nftMarketplacesWithSpam.toString());
      print('NftMarketplacesWithSpamState' +
          state.nftMarketplacesWithSpam.toString());
      emit(NftsMarketplacesWithSpamChargedState(
        nearAccountID: state.nearAccountID,
        isMainnet: state.isMainnet,
        validAccount: state.validAccount,
        nftMarketplacesWithSpam: event.nftMarketplacesWithSpam,
      ));
    }

    void _onSetNftMarketplacesPreCleanEvent(
        NftMarketplacesPreCleanEvent event, Emitter<NftsState> emit) {
      log('NftMarketplacesPreCleanEvent' + DateTime.now().toString());
      print('NftMarketplacesPreCleanState' +
          event.marketplacesPreClean.toString());
      print('NftMarketplacesPreCleanState' +
          state.nftMarketplacesWithSpam.toString());
      emit(NftsMarketplacesPreCleanChargedState(
        nearAccountID: state.nearAccountID,
        isMainnet: state.isMainnet,
        validAccount: state.validAccount,
        nftMarketplacesWithSpam: state.nftMarketplacesWithSpam,
        nftMarketplacesPreClean: event.marketplacesPreClean,
      ));
    }

    void _onNftsSetAccountWithoutFetchEvent(
        NftsSetAccountWithoutFetchEvent event, Emitter<NftsState> emit) {
      log('NftsSetAccountWithoutFetchEvent' + DateTime.now().toString());
      emit(NftsSetAccountWithoutFetchChargedState(
          nearAccountID: event.nearAccountID,
          isMainnet: event.isMainnet,
          validAccount: event.validAccount));
    }

    void _onNftsLoadingEvent(NftsLoadingEvent event, Emitter<NftsState> emit) {
      log('NftsLoadingEvent' + DateTime.now().toString());
      emit(NftsLoadingState(
        nearAccountID: event.nearAccountID,
        isMainnet: event.isMainnet,
        validAccount: event.validAccount,
      ));
    }

    on<NftsInitialEvent>(_onNftsInitialEvent);
    on<NftsSetAccountWithoutFetchEvent>(_onNftsSetAccountWithoutFetchEvent);
    on<NftsLoadingEvent>(_onNftsLoadingEvent);
    on<NftMarketplacesWithSpamEvent>(_onSetNftMarketplacesWithSpamEvent);
    on<NftMarketplacesPreCleanEvent>(_onSetNftMarketplacesPreCleanEvent);
  }
}
