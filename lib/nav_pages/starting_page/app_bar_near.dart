import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nft_gallery/providers/bloc/nfts_bloc.dart';

class AppBarNear extends StatelessWidget {
  const AppBarNear({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: BlocBuilder<NftsBloc, NftsState>(
        buildWhen: (previous, current) =>
            previous.nearAccountID != current.nearAccountID,
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('NFT Gallery'),
              Text(
                'Account: ' + state.nearAccountID,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(),
            ],
          );
        },
      ),
      elevation: 10,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color(0xFFFF5252),
              Color(0xFF448AFF),
            ],
          ),
        ),
      ),
    );
  }
}

class SliverAppBarNear extends StatelessWidget {
  const SliverAppBarNear({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: BlocBuilder<NftsBloc, NftsState>(
          buildWhen: (previous, current) =>
              previous.nearAccountID != current.nearAccountID,
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('NFT Gallery'),
                Text(
                  'Account: ' + state.nearAccountID,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                const SizedBox(),
              ],
            );
          },
        ),
        background: // Colors from the original design
            Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xFFFF5252),
                Color(0xFF448AFF),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
