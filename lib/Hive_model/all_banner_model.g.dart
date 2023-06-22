// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_banner_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AllBannerDetailModelAdapter extends TypeAdapter<AllBannerDetailModel> {
  @override
  final int typeId = 3;

  @override
  AllBannerDetailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AllBannerDetailModel(
      docId: fields[0] as String?,
      bannerImage: fields[2] as dynamic,
      bannerName: fields[1] as String?,
      dateTime: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AllBannerDetailModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.docId)
      ..writeByte(1)
      ..write(obj.bannerName)
      ..writeByte(2)
      ..write(obj.bannerImage)
      ..writeByte(3)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllBannerDetailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
