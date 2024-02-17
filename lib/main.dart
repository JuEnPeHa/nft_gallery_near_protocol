import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nft_gallery/models/nft.dart';
import 'package:nft_gallery/providers/bloc/nfts_bloc.dart';
import 'package:nft_gallery/providers/nfts_provider.dart';
import 'package:nft_gallery/utils/graphiQL_functions.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NftFinalAdapter());
  await listOfAllNftContracts('', operationsDoc, 'MyQuery');
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('AppState build' + DateTime.now().toString());
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NftsProvider(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NftsBloc>(
            create: (_) => NftsBloc(),
          ),
        ],
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    log('MyApp build' + DateTime.now().toString());
    return Builder(
      builder: (context) {
        log('MyApp Builder build' + DateTime.now().toString());
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashPage(),
        );
      },
    );
  }
}

// Let's charge te data to this page
// Vamos a cargar los datos a esta página
class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('SplashPage build' + DateTime.now().toString());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      log('SplashPage addPostFrameCallback' + DateTime.now().toString());
      context.read<NftsProvider>().initState(context);
      log('SplashPage addPostFrameCallback end' + DateTime.now().toString());
    });
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
