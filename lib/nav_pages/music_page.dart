// import 'package:nft_gallery/components/custom_list_tile.dart';
// import 'package:nft_gallery/models/nft.dart';
// import 'package:nft_gallery/widgets/neumor.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';

// class MusicPage extends StatefulWidget {
//   final List<NftFinal> nfts;
//   const MusicPage({Key? key, required this.nfts}) : super(key: key);

//   @override
//   _MusicPageState createState() => _MusicPageState();
// }

// class _MusicPageState extends State<MusicPage> {
//   String currentTitle = "";
//   String currentCover = "";
//   String currentSinger = "";

//   IconData btnIcon = Icons.play_arrow;

//   late final AudioPlayer audioPlayer;

//   @override
//   void initState() {
//     audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
//     audioPlayer.onPlayerCompletion.listen((event) {
//       setState(() {
//         btnIcon = Icons.play_arrow;
//       });
//     });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     audioPlayer.stop();
//     audioPlayer.dispose();
//     super.dispose();
//   }

//   bool isPlaying = false;
//   String currentSong = "";

//   Duration duration = Duration();
//   Duration position = Duration();

//   void setStateIfMounted(VoidCallback fn) {
//     if (mounted) setState(fn);
//   }

//   void playMusic(String url) async {
//     if (isPlaying && currentSong != url) {
//       audioPlayer.pause();
//       int result = await audioPlayer.play(url);
//       if (result == 1) {
//         setState(() {
//           currentSong = url;
//           btnIcon = Icons.pause_circle_filled_outlined;
//         });
//       }
//     } else if (isPlaying && currentSong == url) {
//       audioPlayer.seek(duration);
//       int result = await audioPlayer.play(url);
//       if (result == 1) {
//         setState(() {
//           currentSong = url;
//           btnIcon = Icons.pause_circle_filled_outlined;
//         });
//       }
//     } else if (!isPlaying) {
//       int result = await audioPlayer.play(url);
//       if (result == 1) {
//         setState(() {
//           currentSong = url;
//           isPlaying = true;
//           btnIcon = Icons.pause_circle_filled_outlined;
//         });
//       }
//     }
//     audioPlayer.onDurationChanged.listen((event) {
//       setStateIfMounted(() {
//         print("ondurationchanged");
//         duration = event;
//       });
//     });
//     audioPlayer.onAudioPositionChanged.listen((event) {
//       setStateIfMounted(() {
//         print("onpositionchanged");
//         position = event;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<NftFinal> musicNfts = widget.nfts.where((nft) => nft.isMusic).toList();
//     return Column(
//       children: [
//         Expanded(
//           flex: 4,
//           child: ListView.builder(
//             itemCount: musicNfts.length,
//             itemBuilder: (context, index) => customListTile(
//                 title: musicNfts[index].title,
//                 singer: musicNfts[index].artist,
//                 cover: musicNfts[index].principalImageUrl,
//                 onTap: () {
//                   playMusic(musicNfts[index].musicOrVideoUrl);
//                   setState(() {
//                     audioPlayer.seek(Duration(microseconds: 1));
//                     currentTitle = musicNfts[index].title;
//                     currentCover = musicNfts[index].principalImageUrl;
//                     currentSinger = musicNfts[index].artist;
//                   });
//                 }),
//           ),
//         ),
//         Container(
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Color(0x55212121),
//                 blurRadius: 8.0,
//               ),
//             ],
//           ),
//           child: NeumorConverter(
//             principalColor: Colors.grey,
//             padding: 2,
//             child: Slider.adaptive(
//                 value: position.inMilliseconds.toDouble() ==
//                         duration.inMilliseconds.toDouble()
//                     ? 0.0
//                     : position.inMilliseconds.toDouble(),
//                 min: 0.0,
//                 //divisions: 1,
//                 max: duration.inMilliseconds.toDouble() + 10,
//                 onChanged: (double value) {
//                   print(value.toString() +
//                       " " +
//                       position.inMilliseconds.toString() +
//                       " " +
//                       duration.inMilliseconds.toString());
//                   // audioPlayer.seek(Duration(
//                   //     milliseconds: (value * duration.inMilliseconds).round()));
//                   // if (value + 3 >= duration.inMilliseconds) {
//                   //   setState(() {
//                   //     audioPlayer.pause();
//                   //     audioPlayer.seek(const Duration(milliseconds: 0));
//                   //     btnIcon = Icons.play_circle_fill_outlined;
//                   //     isPlaying = false;
//                   //   });
//                   // }
//                 }),
//           ),
//         ),
//         NeumorConverter(
//           principalColor: Colors.grey,
//           padding: 5,
//           child: Container(
//             color: Colors.grey[200],
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 12, left: 8, right: 8),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     height: 80,
//                     width: 80,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(50),
//                       image: currentCover != ""
//                           ? DecorationImage(
//                               image: NetworkImage(currentCover),
//                             )
//                           : null,
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           currentTitle,
//                           style: const TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.w600),
//                         ),
//                         const SizedBox(
//                           height: 5,
//                         ),
//                         Text(
//                           currentSinger,
//                           style:
//                               const TextStyle(fontSize: 14, color: Colors.grey),
//                         )
//                       ],
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       audioPlayer.pause();
//                       //position = duration - duration;
//                       audioPlayer.seek(const Duration(milliseconds: 0));
//                       setState(() {
//                         btnIcon = Icons.play_circle_fill_outlined;
//                         isPlaying = false;
//                       });
//                     },
//                     icon: const Icon(Icons.stop_circle_outlined),
//                     iconSize: 40,
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       if (isPlaying) {
//                         audioPlayer.pause();
//                         setState(() {
//                           btnIcon = Icons.play_circle_fill_outlined;
//                           isPlaying = false;
//                         });
//                       } else {
//                         audioPlayer.resume();
//                         setState(() {
//                           btnIcon = Icons.pause_circle_filled_outlined;
//                           isPlaying = true;
//                         });
//                       }
//                     },
//                     iconSize: 40,
//                     icon: Icon(btnIcon),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

// int getCurrentTime(int currentTime, int maxTime) {
//   return currentTime * maxTime ~/ 100;
// }
