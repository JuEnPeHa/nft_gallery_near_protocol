import 'package:nft_gallery/models/nft.dart';
import 'package:flutter/material.dart';

class DocumentPage extends StatefulWidget {
  const DocumentPage({Key? key, required List<NftFinal> nfts})
      : super(key: key);

  @override
  _DocumentPageState createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: const Center(
        child: Text('DocumentPage'),
      ),
    );
  }
}
