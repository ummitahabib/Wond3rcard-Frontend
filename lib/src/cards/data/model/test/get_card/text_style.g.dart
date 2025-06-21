// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_style.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TextStyleAdapter extends TypeAdapter<TextStyle> {
  @override
  final int typeId = 0;

  @override
  TextStyle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TextStyle(
      fontSize: fields[0] as String?,
      fontStyle: fields[1] as String?,
      fontWeight: fields[2] as String?,
      textAlign: fields[3] as String?,
      textColor: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TextStyle obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.fontSize)
      ..writeByte(1)
      ..write(obj.fontStyle)
      ..writeByte(2)
      ..write(obj.fontWeight)
      ..writeByte(3)
      ..write(obj.textAlign)
      ..writeByte(4)
      ..write(obj.textColor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TextStyleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
