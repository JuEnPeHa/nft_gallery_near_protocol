import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nft_gallery/providers/bloc/nfts_bloc.dart';

void showInvalidAccountDialog(BuildContext context) {
  showCupertinoDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: const Text('Invalid account'),
          content: const Text('Please enter a valid account'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      });
}

class StartingPage extends StatelessWidget {
  const StartingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBarNear(),
          ),
          body: BodyNearAccount()),
    );
  }
}

class BodyNearAccount extends StatelessWidget {
  const BodyNearAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Column(
            children: const <Widget>[
              SizedBox(
                height: 20,
              ),
              TextoIngresarNEARAccount(),
              SizedBox(
                height: 20,
              ),
              NearAccountInput(),
              SizedBox(
                height: 20,
              ),
              // NearAccountButton(),
            ],
          ),
        ),
      ],
    );
  }
}

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
            },
            onSubmitted: (value) {
              // _submit();
            },
          );
        },
      ),
    );
  }
}

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
