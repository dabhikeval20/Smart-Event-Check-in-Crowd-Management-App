// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParticipantModelAdapter extends TypeAdapter<ParticipantModel> {
  @override
  final int typeId = 3;

  @override
  ParticipantModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ParticipantModel(
      id: fields[0] as String,
      name: fields[1] as String,
      checkedIn: fields[2] as bool,
      checkInTime: fields[3] as DateTime?,
      syncStatus: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ParticipantModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.checkedIn)
      ..writeByte(3)
      ..write(obj.checkInTime)
      ..writeByte(4)
      ..write(obj.syncStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParticipantModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
