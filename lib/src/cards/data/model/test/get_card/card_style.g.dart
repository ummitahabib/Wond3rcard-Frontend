// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_style.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardStyleAdapter extends TypeAdapter<CardStyle> {
  @override
  final int typeId = 0;

  @override
  CardStyle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardStyle(
      fontSize: fields[0] as String?,
      fontStyle: fields[1] as String?,
      fontWeight: fields[2] as String?,
      textAlign: fields[3] as String?,
      textColor: fields[4] as String?,
      borderStyle: fields[5] as String?,
      borderColor: fields[6] as String?,
      borderWidth: fields[7] as String?,
      borderRadius: fields[8] as String?,
      padding: fields[9] as String?,
      margin: fields[10] as String?,
      orientation: fields[11] as String?,
      alignment: fields[12] as String?,
      boxShadow: fields[13] as String?,
      primaryColor: fields[14] as String?,
      secondaryColor: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CardStyle obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.fontSize)
      ..writeByte(1)
      ..write(obj.fontStyle)
      ..writeByte(2)
      ..write(obj.fontWeight)
      ..writeByte(3)
      ..write(obj.textAlign)
      ..writeByte(4)
      ..write(obj.textColor)
      ..writeByte(5)
      ..write(obj.borderStyle)
      ..writeByte(6)
      ..write(obj.borderColor)
      ..writeByte(7)
      ..write(obj.borderWidth)
      ..writeByte(8)
      ..write(obj.borderRadius)
      ..writeByte(9)
      ..write(obj.padding)
      ..writeByte(10)
      ..write(obj.margin)
      ..writeByte(11)
      ..write(obj.orientation)
      ..writeByte(12)
      ..write(obj.alignment)
      ..writeByte(13)
      ..write(obj.boxShadow)
      ..writeByte(14)
      ..write(obj.primaryColor)
      ..writeByte(15)
      ..write(obj.secondaryColor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardStyleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
