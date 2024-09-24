// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_of_day.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PartOfDayAdapter extends TypeAdapter<PartOfDay> {
  @override
  final int typeId = 3;

  @override
  PartOfDay read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PartOfDay.morning;
      case 1:
        return PartOfDay.afternoon;
      case 2:
        return PartOfDay.evening;
      default:
        return PartOfDay.morning;
    }
  }

  @override
  void write(BinaryWriter writer, PartOfDay obj) {
    switch (obj) {
      case PartOfDay.morning:
        writer.writeByte(0);
        break;
      case PartOfDay.afternoon:
        writer.writeByte(1);
        break;
      case PartOfDay.evening:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PartOfDayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
