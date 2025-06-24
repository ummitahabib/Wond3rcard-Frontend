// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getcard.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetCardAdapter extends TypeAdapter<GetCard> {
  @override
  final int typeId = 0;

  @override
  GetCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetCard(
      statusCode: fields[0] as int?,
      status: fields[1] as String?,
      message: fields[2] as String?,
      payload: fields[3] as Payload?,
    );
  }

  @override
  void write(BinaryWriter writer, GetCard obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.statusCode)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.message)
      ..writeByte(3)
      ..write(obj.payload);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PayloadAdapter extends TypeAdapter<Payload> {
  @override
  final int typeId = 1;

  @override
  Payload read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Payload(
      cards: (fields[0] as List?)?.cast<CardData>(),
    );
  }

  @override
  void write(BinaryWriter writer, Payload obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.cards);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PayloadAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CardDataAdapter extends TypeAdapter<CardData> {
  @override
  final int typeId = 2;

  @override
  CardData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardData(
      cardStyle: fields[0] as CardStyle?,
      organizationInfo: fields[1] as OrganizationInfo?,
      contactInfo: fields[2] as ContactInfo?,
      prefix: fields[3] as String?,
      pronoun: fields[4] as String?,
      id: fields[5] as String?,
      cardType: fields[6] as String?,
      creatorId: fields[7] as String?,
      ownerId: fields[8] as String?,
      textStyle: fields[9] as TextStyle?,
      cardDesign: fields[10] as CardDesign?,
      cardLayout: fields[11] as CardLayout?,
      socialMediaLinks: (fields[12] as List?)?.cast<SocialMediaLink>(),
      cardName: fields[13] as String?,
      suffix: fields[14] as String?,
      firstName: fields[15] as String?,
      otherName: fields[16] as String?,
      lastName: fields[17] as String?,
      designation: fields[18] as String?,
      testimonials: (fields[19] as List?)?.cast<dynamic>(),
      videoUrl: fields[20] as String?,
      cardPictureUrl: fields[21] as String?,
      cardCoverUrl: fields[22] as String?,
      cardColor: fields[23] as String?,
      active: fields[24] as bool?,
      createdAt: fields[25] as DateTime?,
      updatedAt: fields[26] as DateTime?,
      v: fields[27] as int?,
      catalogue: (fields[28] as List?)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, CardData obj) {
    writer
      ..writeByte(29)
      ..writeByte(0)
      ..write(obj.cardStyle)
      ..writeByte(1)
      ..write(obj.organizationInfo)
      ..writeByte(2)
      ..write(obj.contactInfo)
      ..writeByte(3)
      ..write(obj.prefix)
      ..writeByte(4)
      ..write(obj.pronoun)
      ..writeByte(5)
      ..write(obj.id)
      ..writeByte(6)
      ..write(obj.cardType)
      ..writeByte(7)
      ..write(obj.creatorId)
      ..writeByte(8)
      ..write(obj.ownerId)
      ..writeByte(9)
      ..write(obj.textStyle)
      ..writeByte(10)
      ..write(obj.cardDesign)
      ..writeByte(11)
      ..write(obj.cardLayout)
      ..writeByte(12)
      ..write(obj.socialMediaLinks)
      ..writeByte(13)
      ..write(obj.cardName)
      ..writeByte(14)
      ..write(obj.suffix)
      ..writeByte(15)
      ..write(obj.firstName)
      ..writeByte(16)
      ..write(obj.otherName)
      ..writeByte(17)
      ..write(obj.lastName)
      ..writeByte(18)
      ..write(obj.designation)
      ..writeByte(19)
      ..write(obj.testimonials)
      ..writeByte(20)
      ..write(obj.videoUrl)
      ..writeByte(21)
      ..write(obj.cardPictureUrl)
      ..writeByte(22)
      ..write(obj.cardCoverUrl)
      ..writeByte(23)
      ..write(obj.cardColor)
      ..writeByte(24)
      ..write(obj.active)
      ..writeByte(25)
      ..write(obj.createdAt)
      ..writeByte(26)
      ..write(obj.updatedAt)
      ..writeByte(27)
      ..write(obj.v)
      ..writeByte(28)
      ..write(obj.catalogue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ContactInfoAdapter extends TypeAdapter<ContactInfo> {
  @override
  final int typeId = 3;

  @override
  ContactInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContactInfo(
      emailType: (fields[0] as List?)?.cast<dynamic>(),
      email: fields[1] as String?,
      phone: fields[2] as String?,
      website: fields[3] as String?,
      address: fields[4] as String?,
      addresses: (fields[5] as List?)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, ContactInfo obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.emailType)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.website)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.addresses);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SocialMediaLinkAdapter extends TypeAdapter<SocialMediaLink> {
  @override
  final int typeId = 4;

  @override
  SocialMediaLink read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SocialMediaLink(
      media: fields[0] as Media?,
      username: fields[1] as String?,
      active: fields[2] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, SocialMediaLink obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.media)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.active);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SocialMediaLinkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MediaAdapter extends TypeAdapter<Media> {
  @override
  final int typeId = 5;

  @override
  Media read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Media(
      iconUrl: fields[0] as String?,
      name: fields[1] as String?,
      type: fields[2] as String?,
      link: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Media obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.iconUrl)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.link);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MediaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
