// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SocialDataAdapter extends TypeAdapter<SocialData> {
  @override
  final int typeId = 0;

  @override
  SocialData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SocialData(
      title: fields[0] as String,
      username: fields[1] as String,
      password: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SocialData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SocialDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
