// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_design.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardDesignAdapter extends TypeAdapter<CardDesign> {
  @override
  final int typeId = 1;

  @override
  CardDesign read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardDesign(
      backgroundColor: fields[0] as String?,
      backgroundImage: fields[1] as String?,
      borderStyle: fields[2] as String?,
      borderColor: fields[3] as String?,
      borderWidth: fields[4] as String?,
      borderRadius: fields[5] as String?,
      boxShadow: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CardDesign obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.backgroundColor)
      ..writeByte(1)
      ..write(obj.backgroundImage)
      ..writeByte(2)
      ..write(obj.borderStyle)
      ..writeByte(3)
      ..write(obj.borderColor)
      ..writeByte(4)
      ..write(obj.borderWidth)
      ..writeByte(5)
      ..write(obj.borderRadius)
      ..writeByte(6)
      ..write(obj.boxShadow);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardDesignAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
