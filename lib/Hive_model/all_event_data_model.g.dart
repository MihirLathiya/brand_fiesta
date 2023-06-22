// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_event_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AllEventDetailModelAdapter extends TypeAdapter<AllEventDetailModel> {
  @override
  final int typeId = 2;

  @override
  AllEventDetailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AllEventDetailModel(
      docId: fields[0] as String?,
      upcoming: fields[2] as bool?,
      thumbNail: fields[3] as dynamic,
      eventName: fields[1] as String?,
      dateTime: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AllEventDetailModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.docId)
      ..writeByte(1)
      ..write(obj.eventName)
      ..writeByte(2)
      ..write(obj.upcoming)
      ..writeByte(3)
      ..write(obj.thumbNail)
      ..writeByte(4)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllEventDetailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
