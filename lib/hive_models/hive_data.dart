import 'package:audio_player/models/nft.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveData {
  const HiveData();
  Future<int> saveNft(NftFinal nft) async {
    final Box<NftFinal> box = await Hive.openBox<NftFinal>('nfts');
    return box.add(nft);
  }

  Future<List<int>> saveNfts(List<NftFinal> nfts) async {
    List<int> ids = [];
    final Box<NftFinal> box = await Hive.openBox<NftFinal>('nfts');
    for (NftFinal nft in nfts) {
     box.add(nft).then((value) => ids.add(value));
    }
    print("IDSIDSIDSIDSIDSIDSIDIS:" + ids.toString());
    return ids;
  }

  Future<List<NftFinal>> get nfts async {
    final Box<NftFinal> box = await Hive.openBox<NftFinal>('nfts');
    return box.values.toList();
  }

  void deleteNft(int id) async {
    final Box<NftFinal> box = await Hive.openBox<NftFinal>('nfts');
    box.delete(id);
  }

  void deleteNfts(List<int> ids) async {
    final Box<NftFinal> box = await Hive.openBox<NftFinal>('nfts');
    for (int id in ids) {
      box.delete(id);
    }
  }

  void deleteAllNfts() async {
    final Box<NftFinal> box = await Hive.openBox<NftFinal>('nfts');
    box.clear();
  }
}
