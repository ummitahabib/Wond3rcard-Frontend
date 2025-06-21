// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrganizationInfoAdapter extends TypeAdapter<OrganizationInfo> {
  @override
  final int typeId = 0;

  @override
  OrganizationInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrganizationInfo(
      organizationName: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, OrganizationInfo obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.organizationName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrganizationInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
