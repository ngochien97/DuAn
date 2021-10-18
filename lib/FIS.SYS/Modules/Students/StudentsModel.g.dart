// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StudentsModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentsModelAdapter extends TypeAdapter<StudentsModel> {
  @override
  final int typeId = 1;

  @override
  StudentsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentsModel()..students = (fields[0] as List)?.cast<StudentItem>();
  }

  @override
  void write(BinaryWriter writer, StudentsModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.students);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
