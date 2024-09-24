// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repeat_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RepeatTypeAdapter extends TypeAdapter<RepeatType> {
  @override
  final int typeId = 2;

  @override
  RepeatType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RepeatType.weekly;
      case 1:
        return RepeatType.monthly;
      default:
        return RepeatType.weekly;
    }
  }

  @override
  void write(BinaryWriter writer, RepeatType obj) {
    switch (obj) {
      case RepeatType.weekly:
        writer.writeByte(0);
        break;
      case RepeatType.monthly:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RepeatTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
