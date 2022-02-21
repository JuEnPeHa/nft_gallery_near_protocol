import 'package:audio_player/cuarta_page.dart';
import 'package:audio_player/hive_models/hive_data.dart';
import 'package:audio_player/models/nft.dart';
import 'package:audio_player/quinta_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NftFinalAdapter());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final HiveData hiveData = const HiveData();
  List<NftFinal> nfts = [];
  Future<void> _initHive() async {
    nfts = await hiveData.nfts;
    setState(() {});
  }

  @override
  void initState() {
    _initHive();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: nfts.isEmpty ? const CuartaPage() : const QuintaPage(),
    );
  }
}
