// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swimming_session.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SwimmingSessionAdapter extends TypeAdapter<SwimmingSession> {
  @override
  final int typeId = 1;

  @override
  SwimmingSession read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SwimmingSession(
      pools: fields[0] as int,
      date: fields[2] as DateTime,
    )..meters = fields[1] as int;
  }

  @override
  void write(BinaryWriter writer, SwimmingSession obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.pools)
      ..writeByte(1)
      ..write(obj.meters)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SwimmingSessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
