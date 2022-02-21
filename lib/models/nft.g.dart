// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NftFinalAdapter extends TypeAdapter<NftFinal> {
  @override
  final int typeId = 1;

  @override
  NftFinal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NftFinal(
      id: fields[0] as int,
      title: fields[1] as String,
      description: fields[2] as String,
      principalImageUrl: fields[3] as String,
      musicOrVideoUrl: fields[4] as String,
      documentUrl: fields[5] as String,
      isMusic: fields[6] as bool,
      isDoc: fields[7] as bool,
      isVideo: fields[8] as bool,
      artist: fields[9] as String,
      category: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NftFinal obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.principalImageUrl)
      ..writeByte(4)
      ..write(obj.musicOrVideoUrl)
      ..writeByte(5)
      ..write(obj.documentUrl)
      ..writeByte(6)
      ..write(obj.isMusic)
      ..writeByte(7)
      ..write(obj.isDoc)
      ..writeByte(8)
      ..write(obj.isVideo)
      ..writeByte(9)
      ..write(obj.artist)
      ..writeByte(10)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NftFinalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
