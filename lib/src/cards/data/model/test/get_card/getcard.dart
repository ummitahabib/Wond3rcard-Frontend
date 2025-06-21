import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:wond3rcard/src/cards/data/model/test/get_card/card_layout.dart';
import 'package:wond3rcard/src/cards/data/model/test/get_card/organization_info.dart';

import 'card_design.dart';
import 'card_style.dart';
import 'text_style.dart';
part 'getcard.g.dart';

@HiveType(typeId: 0)
class GetCard extends HiveObject {
  @HiveField(0)
  int? statusCode;

  @HiveField(1)
  String? status;

  @HiveField(2)
  String? message;

  @HiveField(3)
  Payload? payload;

  GetCard({this.statusCode, this.status, this.message, this.payload});

  factory GetCard.fromMap(Map<String, dynamic> map) => GetCard(
        statusCode: map['statusCode'],
        status: map['status'],
        message: map['message'],
        payload:
            map['payload'] == null ? null : Payload.fromMap(map['payload']),
      );

  Map<String, dynamic> toMap() => {
        'statusCode': statusCode,
        'status': status,
        'message': message,
        'payload': payload?.toMap(),
      };

  factory GetCard.fromJson(String source) =>
      GetCard.fromMap(Map<String, dynamic>.from(jsonDecode(source)));

  String toJson() => jsonEncode(toMap());
}

@HiveType(typeId: 1)
class Payload extends HiveObject {
  @HiveField(0)
  List<CardData>? cards;

  Payload({this.cards});

  factory Payload.fromMap(Map<String, dynamic> map) => Payload(
        cards: map['cards'] == null
            ? []
            : List<CardData>.from(
                (map['cards'] as List).map((x) => CardData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'cards': cards?.map((x) => x.toMap()).toList(),
      };
}

@HiveType(typeId: 2)
class CardData extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? firstName;

  @HiveField(2)
  String? lastName;

  @HiveField(3)
  String? cardName;

  @HiveField(4)
  ContactInfo? contactInfo;

  CardData({
    this.id,
    this.firstName,
    this.lastName,
    this.cardName,
    this.contactInfo,
  });

  factory CardData.fromMap(Map<String, dynamic> map) => CardData(
        id: map['id'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        cardName: map['cardName'],
        contactInfo: map['contactInfo'] == null
            ? null
            : ContactInfo.fromMap(map['contactInfo']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'cardName': cardName,
        'contactInfo': contactInfo?.toMap(),
      };
}

@HiveType(typeId: 3)
class ContactInfo extends HiveObject {
  @HiveField(0)
  String? email;

  @HiveField(1)
  String? phone;

  ContactInfo({this.email, this.phone});

  factory ContactInfo.fromMap(Map<String, dynamic> map) => ContactInfo(
        email: map['email'],
        phone: map['phone'],
      );

  Map<String, dynamic> toMap() => {
        'email': email,
        'phone': phone,
      };
}




@HiveType(typeId: 4)
class Card extends HiveObject {
  @HiveField(0)
  CardStyle? cardStyle;

  @HiveField(1)
  OrganizationInfo? organizationInfo;

  @HiveField(2)
  ContactInfo? contactInfo;

  @HiveField(3)
  String? prefix;

  @HiveField(4)
  String? pronoun;

  @HiveField(5)
  String? id;

  @HiveField(6)
  String? cardType;

  @HiveField(7)
  String? creatorId;

  @HiveField(8)
  String? ownerId;

  @HiveField(9)
  TextStyle? textStyle;

  @HiveField(10)
  CardDesign? cardDesign;

  @HiveField(11)
  CardLayout? cardLayout;

  @HiveField(12)
  List<SocialMediaLink>? socialMediaLinks;

  @HiveField(13)
  String? cardName;

  @HiveField(14)
  String? suffix;

  @HiveField(15)
  String? firstName;

  @HiveField(16)
  String? otherName;

  @HiveField(17)
  String? lastName;

  @HiveField(18)
  String? designation;

  @HiveField(19)
  List<dynamic>? testimonials;

  @HiveField(20)
  String? videoUrl;

  @HiveField(21)
  String? cardPictureUrl;

  @HiveField(22)
  String? cardCoverUrl;

  @HiveField(23)
  String? cardColor;

  @HiveField(24)
  bool? active;

  @HiveField(25)
  DateTime? createdAt;

  @HiveField(26)
  DateTime? updatedAt;

  @HiveField(27)
  int? v;

  @HiveField(28)
  List<dynamic>? catelogue;

  Card({
    this.cardStyle,
    this.organizationInfo,
    this.contactInfo,
    this.prefix,
    this.pronoun,
    this.id,
    this.cardType,
    this.creatorId,
    this.ownerId,
    this.textStyle,
    this.cardDesign,
    this.cardLayout,
    this.socialMediaLinks,
    this.cardName,
    this.suffix,
    this.firstName,
    this.otherName,
    this.lastName,
    this.designation,
    this.testimonials,
    this.videoUrl,
    this.cardPictureUrl,
    this.cardCoverUrl,
    this.cardColor,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.catelogue,
  });

  factory Card.fromMap(Map<String, dynamic> data) => Card(
        cardStyle: data['cardStyle'] == null
            ? null
            : CardStyle.fromMap(data['cardStyle'] as Map<String, dynamic>),
        organizationInfo: data['organizationInfo'] == null
            ? null
            : OrganizationInfo.fromMap(
                data['organizationInfo'] as Map<String, dynamic>),
        contactInfo: data['contactInfo'] == null
            ? null
            : ContactInfo.fromMap(data['contactInfo'] as Map<String, dynamic>),
        prefix: data['prefix'] as String?,
        pronoun: data['pronoun'] as String?,
        id: data['_id'] as String?,
        cardType: data['cardType'] as String?,
        creatorId: data['creatorId'] as String?,
        ownerId: data['ownerId'] as String?,
        textStyle: data['textStyle'] == null
            ? null
            : TextStyle.fromMap(data['textStyle'] as Map<String, dynamic>),
        cardDesign: data['cardDesign'] == null
            ? null
            : CardDesign.fromMap(data['cardDesign'] as Map<String, dynamic>),
        cardLayout: data['cardLayout'] == null
            ? null
            : CardLayout.fromMap(data['cardLayout'] as Map<String, dynamic>),
        socialMediaLinks: (data['socialMediaLinks'] as List<dynamic>?)
            ?.map((e) => SocialMediaLink.fromMap(e as Map<String, dynamic>))
            .toList(),
        cardName: data['cardName'] as String?,
        suffix: data['suffix'] as String?,
        firstName: data['firstName'] as String?,
        otherName: data['otherName'] as String?,
        lastName: data['lastName'] as String?,
        designation: data['designation'] as String?,
        testimonials: data['testimonials'] as List<dynamic>?,
        videoUrl: data['videoUrl'] as String?,
        cardPictureUrl: data['cardPictureUrl'] as String?,
        cardCoverUrl: data['cardCoverUrl'] as String?,
        cardColor: data['cardColor'] as String?,
        active: data['active'] as bool?,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
        v: data['__v'] as int?,
        catelogue: data['catelogue'] as List<dynamic>?,
      );

  Map<String, dynamic> toMap() => {
        'cardStyle': cardStyle?.toMap(),
        'organizationInfo': organizationInfo?.toMap(),
        'contactInfo': contactInfo?.toMap(),
        'prefix': prefix,
        'pronoun': pronoun,
        '_id': id,
        'cardType': cardType,
        'creatorId': creatorId,
        'ownerId': ownerId,
        'textStyle': textStyle?.toMap(),
        'cardDesign': cardDesign?.toMap(),
        'cardLayout': cardLayout?.toMap(),
        'socialMediaLinks': socialMediaLinks?.map((e) => e.toMap()).toList(),
        'cardName': cardName,
        'suffix': suffix,
        'firstName': firstName,
        'otherName': otherName,
        'lastName': lastName,
        'designation': designation,
        'testimonials': testimonials,
        'videoUrl': videoUrl,
        'cardPictureUrl': cardPictureUrl,
        'cardCoverUrl': cardCoverUrl,
        'cardColor': cardColor,
        'active': active,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
        'catelogue': catelogue,
      };

  factory Card.fromJson(String data) {
    return Card.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}

@HiveType(typeId: 5)
class SocialMediaLink extends HiveObject {
  @HiveField(0)
  Media? media;

  @HiveField(1)
  String? username;

  @HiveField(2)
  bool? active;

  SocialMediaLink({
    this.media,
    this.username,
    this.active,
  });

  factory SocialMediaLink.fromMap(Map<String, dynamic> map) {
    return SocialMediaLink(
      media: map['media'] != null ? Media.fromMap(map['media']) : null,
      username: map['username'],
      active: map['active'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'media': media?.toMap(),
      'username': username,
      'active': active,
    };
  }
}

@HiveType(typeId: 6)
class Media extends HiveObject {
  @HiveField(0)
  String? iconUrl;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? type;

  @HiveField(3)
  String? link;

  Media({
    this.iconUrl,
    this.name,
    this.type,
    this.link,
  });

  factory Media.fromMap(Map<String, dynamic> map) {
    return Media(
      iconUrl: map['iconUrl'],
      name: map['name'],
      type: map['type'],
      link: map['link'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'iconUrl': iconUrl,
      'name': name,
      'type': type,
      'link': link,
    };
  }
}
