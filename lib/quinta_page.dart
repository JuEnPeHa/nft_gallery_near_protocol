import 'package:audio_player/cuarta_page.dart';
import 'package:audio_player/hive_models/hive_data.dart';
import 'package:audio_player/models/nft.dart';
import 'package:audio_player/nav_pages/documents_page.dart';
import 'package:audio_player/nav_pages/gallery_page.dart';
import 'package:audio_player/nav_pages/music_page.dart';
import 'package:audio_player/nav_pages/video_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuintaPage extends StatefulWidget {
  const QuintaPage({Key? key}) : super(key: key);

  @override
  _QuintaPageState createState() => _QuintaPageState();
}

class _QuintaPageState extends State<QuintaPage> {
  final HiveData hiveData = HiveData();
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

  List<Widget> _pages() => [
        GalleryPage(nfts: nfts),
        MusicPage(nfts: nfts),
        VideoPage(nfts: nfts),
        DocumentPage(nfts: nfts)
      ];
  int currentIndex = 0;
  void onTap(int index) {
    List<NftFinal> videosNfts = nfts.where((nft) => nft.isVideo).toList();
    if (index == 2 && videosNfts.isEmpty) {
      return;
    } else {
      setState(() {
        currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = _pages();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Colors.red.shade400.withOpacity(0.85),
              Colors.blue.shade400.withOpacity(0.85)
            ],
          ),
        ),
        child: pages[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[300],
        selectedItemColor: Colors.grey[800],
        unselectedItemColor: Colors.grey[400],
        elevation: 100,
        currentIndex: currentIndex,
        onTap: onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Gallery'),
          BottomNavigationBarItem(icon: Icon(Icons.music_note), label: 'Music'),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_library), label: 'Video'),
          BottomNavigationBarItem(
              icon: Icon(Icons.description), label: 'Document'),
        ],
      ),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          hiveData.deleteAllNfts();
          Navigator.pushReplacement(
              context, CupertinoPageRoute(builder: (context) => CuartaPage()));
        },
        label: Text("Logout"),
      ),
      floatingActionButtonLocation: currentIndex == 1 || currentIndex == 2
          ? FloatingActionButtonLocation.centerTop
          : FloatingActionButtonLocation.endFloat,
    );
  }
}
