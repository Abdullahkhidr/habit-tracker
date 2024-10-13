// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoodTypeAdapter extends TypeAdapter<MoodType> {
  @override
  final int typeId = 51;

  @override
  MoodType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MoodType.great;
      case 1:
        return MoodType.smile;
      case 2:
        return MoodType.normal;
      case 3:
        return MoodType.sad;
      case 4:
        return MoodType.angry;
      default:
        return MoodType.great;
    }
  }

  @override
  void write(BinaryWriter writer, MoodType obj) {
    switch (obj) {
      case MoodType.great:
        writer.writeByte(0);
        break;
      case MoodType.smile:
        writer.writeByte(1);
        break;
      case MoodType.normal:
        writer.writeByte(2);
        break;
      case MoodType.sad:
        writer.writeByte(3);
        break;
      case MoodType.angry:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoodTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
