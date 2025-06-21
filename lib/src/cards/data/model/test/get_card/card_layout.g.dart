// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_layout.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardLayoutAdapter extends TypeAdapter<CardLayout> {
  @override
  final int typeId = 0;

  @override
  CardLayout read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardLayout(
      padding: fields[0] as String?,
      margin: fields[1] as String?,
      layoutOrientation: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CardLayout obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.padding)
      ..writeByte(1)
      ..write(obj.margin)
      ..writeByte(2)
      ..write(obj.layoutOrientation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardLayoutAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
