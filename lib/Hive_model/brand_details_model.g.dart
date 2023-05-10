// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_details_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BrandDetailsModelAdapter extends TypeAdapter<BrandDetailsModel> {
  @override
  final int typeId = 1;

  @override
  BrandDetailsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BrandDetailsModel(
      image: fields[0] as Uint8List,
      website: fields[2] as String,
      address: fields[6] as String,
      name: fields[1] as String,
      contactNumber: fields[3] as String,
      emailId: fields[4] as String,
      dateTime: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BrandDetailsModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.website)
      ..writeByte(3)
      ..write(obj.contactNumber)
      ..writeByte(4)
      ..write(obj.emailId)
      ..writeByte(5)
      ..write(obj.dateTime)
      ..writeByte(6)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BrandDetailsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
