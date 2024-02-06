import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nft_gallery/models/nft.dart';
import 'package:nft_gallery/models/nft_marketplace.dart';

part 'nfts_event.dart';
part 'nfts_state.dart';

class NftsBloc extends Bloc<NftsEvent, NftsState> {
  NftsBloc() : super(NftsInitialState()) {
    on<NftsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
