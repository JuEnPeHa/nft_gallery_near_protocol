import 'package:audio_player/models/nft.dart';
import 'package:audio_player/widgets/neumor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GalleryPage extends StatefulWidget {
  final List<NftFinal> nfts;
  const GalleryPage({Key? key, required this.nfts}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.nfts);
    return Container(
      child: GridView.custom(
        semanticChildCount: widget.nfts.length,
        cacheExtent: 5000,
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverWovenGridDelegate.count(pattern: [
          WovenGridTile(1),
          WovenGridTile(
            5 / 7,
            crossAxisRatio: 0.9,
            alignment: AlignmentDirectional.centerEnd,
          ),
        ], crossAxisCount: 2),
        childrenDelegate: SliverChildBuilderDelegate(
            (context, index) => buildImageCard(index),
            childCount: widget.nfts.length,
            addAutomaticKeepAlives: true),
      ),
    );
  }

  Widget buildImageCard(int index) {
    return NeumorConverter(
      principalColor: Colors.grey,
      padding: 2,
      child: Card(
        elevation: 10,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          margin: const EdgeInsets.all(4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: ((context) => Scaffold(
                              appBar: AppBar(
                                title: Text(widget.nfts[index].title),
                              ),
                              body: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    CachedNetworkImage(
                                        imageUrl: widget
                                            .nfts[index].principalImageUrl),
                                    Text(widget.nfts[index].description,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            overflow: TextOverflow.fade)),
                                    Divider(),
                                    Text(widget.nfts[index].artist,
                                        style: TextStyle(fontSize: 20)),
                                  ],
                                ),
                              ),
                            ))));
              },
              child: CachedNetworkImage(
                imageUrl: widget.nfts[index].principalImageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
