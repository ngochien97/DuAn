// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StudentItem.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentItemAdapter extends TypeAdapter<StudentItem> {
  @override
  final int typeId = 0;

  @override
  StudentItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentItem(
      id: fields[0] as int,
      name: fields[1] as String,
      cardNumber: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, StudentItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.cardNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
