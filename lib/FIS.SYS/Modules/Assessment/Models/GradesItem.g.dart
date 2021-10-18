// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GradesItem.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GradesItemAdapter extends TypeAdapter<GradesItem> {
  @override
  final int typeId = 3;

  @override
  GradesItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GradesItem(
      id: fields[0] as int,
      type: fields[1] as String,
      key: fields[2] as String,
      value: fields[3] as String,
    )..dateCached = fields[4] as DateTime;
  }

  @override
  void write(BinaryWriter writer, GradesItem obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.key)
      ..writeByte(3)
      ..write(obj.value)
      ..writeByte(4)
      ..write(obj.dateCached);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GradesItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
