// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HistoryNotificationItem.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoryNotificationItemAdapter
    extends TypeAdapter<HistoryNotificationItem> {
  @override
  final int typeId = 2;

  @override
  HistoryNotificationItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoryNotificationItem(
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      objectData: fields[6] as String,
    )
      ..id = fields[0] as String
      ..status = fields[4] as int
      ..dateCreated = fields[5] as DateTime;
  }

  @override
  void write(BinaryWriter writer, HistoryNotificationItem obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.objectId)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.message)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.dateCreated)
      ..writeByte(6)
      ..write(obj.objectData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryNotificationItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
