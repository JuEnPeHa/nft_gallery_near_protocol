import 'package:nft_gallery/models/nft.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final List<NftFinal> nfts;
  const VideoPage({Key? key, required this.nfts}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  var title = "";
  List<NftFinal> videosNfts = [];

  @override
  void initState() {
    videosNfts = widget.nfts.where((nft) => nft.isVideo).toList();
    print("AQUIAUIAQUIAQUIAUQUI:" + videosNfts[1].toString());
    _controller = VideoPlayerController.network(
      videosNfts[1].musicOrVideoUrl,
    )
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(true)
      ..initialize().then((value) => _controller.play());
    _initializeVideoPlayerFuture = _controller.initialize();
    title = videosNfts[1].title;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Text titlex = Text(title);
    return Scaffold(
      appBar: AppBar(
        title: titlex,
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (/*snapshot.connectionState == ConnectionState.done*/ _controller
                  .value.isInitialized) {
                return Column(
                  children: [
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                    VideoProgressIndicator(_controller, allowScrubbing: true),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          DropdownButton<String>(
              items: videosNfts.map((e) {
                return DropdownMenuItem<String>(
                  child: Text(e.title),
                  value: e.musicOrVideoUrl,
                  onTap: () {
                    title = e.title;
                    _controller.pause();
                    _controller =
                        VideoPlayerController.network(e.musicOrVideoUrl)
                          ..addListener(() {
                            setState(() {});
                          })
                          ..setLooping(true)
                          ..initialize().then((value) => _controller.play());
                    print("AQUIAUIAQUIAQUIAUQUI:" + e.title);
                  },
                );
              }).toList(),
              onChanged: (_) {}),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // FloatingActionButton(
            //   onPressed: () {
            //     // Envuelve la reproducción o pausa en una llamada a `setState`. Esto asegura
            //     // que se muestra el icono correcto
            //     setState(() {
            //       // Si el vídeo se está reproduciendo, pausalo.
            //       if (_controller.value.isPlaying) {
            //         _controller.pause();
            //       } else {
            //         // Si el vídeo está pausado, reprodúcelo
            //         _controller.play();
            //       }
            //     });
            //   },
            //   // Muestra el icono correcto dependiendo del estado del vídeo.
            //   child: Icon(
            //     videosNfts.isNotEmpty ? Icons.skip_next : Icons.play_arrow,
            //   ),
            // ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
