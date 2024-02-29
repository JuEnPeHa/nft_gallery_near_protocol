import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nft_gallery/nav_pages/starting_page/app_bar_near.dart';
import 'package:nft_gallery/nav_pages/starting_page/body_marketplaces.dart';
import 'package:nft_gallery/nav_pages/starting_page/near_account_input.dart';
import 'package:nft_gallery/providers/bloc/nfts_bloc.dart';
import 'package:nft_gallery/widgets/neumor.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: const Scaffold(
        // appBar: PreferredSize(
        //   preferredSize: const Size.fromHeight(50),
        //   child: AppBarNear(),
        // ),
        body: BodyNearAccount(),
      ),
    );
  }
}

class BodyNearAccount extends StatelessWidget {
  const BodyNearAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        const SliverAppBarNear(),
        // const BannerTestingNewHelperService(),
        SliverToBoxAdapter(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              const TextoIngresarNEARAccount(),
              const SizedBox(
                height: 20,
              ),
              const NearAccountInput(),
              BlocBuilder<NftsBloc, NftsState>(
                buildWhen: (previous, current) {
                  return previous.validAccount != current.validAccount ||
                      previous.isCharging != current.isCharging ||
                      previous.nearAccountID != current.nearAccountID;
                },
                builder: (context, state) {
                  return ButtonBarSubmitClear(
                    onClear: null,
                    // onClear: state.nearAccountID.isEmpty
                    //     ? null
                    //     : () {
                    //         // context.read<NftsBloc>().add(
                    //         //       ClearNearAccount(),
                    //         //     );
                    //       },
                    onSubmit: state.validAccount && !state.isCharging
                        ? () {
                            fetchAll(
                              nearAccountId: state.nearAccountID,
                              context: context,
                            );
                          }
                        : null,
                  );
                },
              ),
              // NearAccountButton(),
              // BodyContratos(), //todo! Descomentar
              BodyMarketplaces(),
            ],
          ),
        ),
        BlocBuilder<NftsBloc, NftsState>(
          buildWhen: (previous, current) =>
              previous.nfts != current.nfts ||
              previous.isCharging != current.isCharging,
          builder: (context, state) {
            return SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return CachedNetworkImage(
                    imageUrl: state.nfts[index].principalImageUrl +
                        '?w=600&auto=format,compress',
                  );
                },
                childCount: state.nfts.length,
              ),
            );
          },
        ),
      ],
    );
  }
}

class ButtonBarSubmitClear extends StatelessWidget {
  const ButtonBarSubmitClear({
    Key? key,
    required this.onClear,
    required this.onSubmit,
  }) : super(key: key);

  final VoidCallback? onClear;
  final VoidCallback? onSubmit;

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceAround,
      children: [
        NeumorConverter(
            principalColor: Colors.grey,
            padding: 2,
            child: CupertinoButton(
              child: const Text("Submit"),
              onPressed: onSubmit,
            )),
        // NeumorConverter(
        //     principalColor: Colors.grey,
        //     padding: 2,
        //     child: CupertinoButton(
        //       child: const Text("Clear"),
        //       onPressed: onClear,
        //     )),
        // Todo: Add a clear button
      ],
    );
  }
}

class BannerTestingNewHelperService extends StatelessWidget {
  const BannerTestingNewHelperService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  color: Colors.red,
                  child: const Text(
                    'Probando un nuevo selvicio, los tiempos de carga podrían ser mayores.',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: MaterialButton(
                  color: Colors.blue,
                  height: 50,
                  onPressed: () {},
                  child: Text(
                    'Update SC',
                  ),
                ),
              ),
            ],
          ),
          Container(
              color: Colors.redAccent,
              height: 50,
              width: double.infinity,
              child: const Center(
                child: Text(
                  'Necesitas actualizar manualmente la lista de contratos y marketplaces. Da click en el botón para actualizar.',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  softWrap: true,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )),
        ],
      ),
    );
  }
}
