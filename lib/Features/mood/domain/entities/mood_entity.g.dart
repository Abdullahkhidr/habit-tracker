// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoodEntityAdapter extends TypeAdapter<MoodEntity> {
  @override
  final int typeId = 50;

  @override
  MoodEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MoodEntity(
      date: fields[0] as DateTime,
      mood: fields[1] as MoodType,
    );
  }

  @override
  void write(BinaryWriter writer, MoodEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.mood);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoodEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
