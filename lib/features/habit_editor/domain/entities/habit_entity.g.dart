// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitEntityAdapter extends TypeAdapter<HabitEntity> {
  @override
  final int typeId = 0;

  @override
  HabitEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitEntity(
      id: fields[0] as int?,
      title: fields[1] as String,
      description: fields[2] as String,
      icon: fields[5] as String,
      type: fields[3] as HabitType,
      color: fields[4] as Color,
      createdAt: fields[6] as DateTime,
      updatedAt: fields[7] as DateTime?,
      repeatingType: fields[8] as RepeatType,
      repeatingDays: (fields[9] as List).cast<int>().toSet(),
      partOfDay: fields[10] as PartOfDay,
      dueDate: fields[11] as DateTime?,
      remainder: fields[12] as TimeOfDay?,
      when: fields[13] as DateTime?,
      completedAt: fields[14] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, HabitEntity obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.color)
      ..writeByte(5)
      ..write(obj.icon)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt)
      ..writeByte(8)
      ..write(obj.repeatingType)
      ..writeByte(9)
      ..write(obj.repeatingDays.toList())
      ..writeByte(10)
      ..write(obj.partOfDay)
      ..writeByte(11)
      ..write(obj.dueDate)
      ..writeByte(12)
      ..write(obj.remainder)
      ..writeByte(13)
      ..write(obj.when)
      ..writeByte(14)
      ..write(obj.completedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
