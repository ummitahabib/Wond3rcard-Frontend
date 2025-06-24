import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:wond3rcard/src/cards/data/model/test/get_card/card_layout.dart';
import 'package:wond3rcard/src/cards/data/model/test/get_card/contact.dart';
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
  final CardStyle? cardStyle;

  @HiveField(1)
  final OrganizationInfo? organizationInfo;

  @HiveField(2)
  final ContactInfo? contactInfo;

  @HiveField(3)
  final String? prefix;

  @HiveField(4)
  final String? pronoun;

  @HiveField(5)
  final String? id;

  @HiveField(6)
  final String? cardType;

  @HiveField(7)
  final String? creatorId;

  @HiveField(8)
  final String? ownerId;

  @HiveField(9)
  final TextStyle? textStyle;

  @HiveField(10)
  final CardDesign? cardDesign;

  @HiveField(11)
  final CardLayout? cardLayout;

  @HiveField(12)
  final List<SocialMediaLink>? socialMediaLinks;

  @HiveField(13)
  final String? cardName;

  @HiveField(14)
  final String? suffix;

  @HiveField(15)
  final String? firstName;

  @HiveField(16)
  final String? otherName;

  @HiveField(17)
  final String? lastName;

  @HiveField(18)
  final String? designation;

  @HiveField(19)
  final List<dynamic>? testimonials;

  @HiveField(20)
  final String? videoUrl;

  @HiveField(21)
  final String? cardPictureUrl;

  @HiveField(22)
  final String? cardCoverUrl;

  @HiveField(23)
  final String? cardColor;

  @HiveField(24)
  final bool? active;

  @HiveField(25)
  final DateTime? createdAt;

  @HiveField(26)
  final DateTime? updatedAt;

  @HiveField(27)
  final int? v;

  @HiveField(28)
  final List<dynamic>? catalogue;

  CardData({
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
    this.catalogue,
  });

  factory CardData.fromMap(Map<String, dynamic> data) {
    return CardData(
      cardStyle: data['cardStyle'] != null
          ? CardStyle.fromMap(data['cardStyle'])
          : null,
      organizationInfo: data['organizationInfo'] != null
          ? OrganizationInfo.fromMap(data['organizationInfo'])
          : null,
      contactInfo: data['contactInfo'] != null
          ? ContactInfo.fromMap(data['contactInfo'])
          : null,
      prefix: data['prefix'],
      pronoun: data['pronoun'],
      id: data['_id'],
      cardType: data['cardType'],
      creatorId: data['creatorId'],
      ownerId: data['ownerId'],
      textStyle: data['textStyle'] != null
          ? TextStyle.fromMap(data['textStyle'])
          : null,
      cardDesign: data['cardDesign'] != null
          ? CardDesign.fromMap(data['cardDesign'])
          : null,
      cardLayout: data['cardLayout'] != null
          ? CardLayout.fromMap(data['cardLayout'])
          : null,
      socialMediaLinks: (data['socialMediaLinks'] as List?)
          ?.map((e) => SocialMediaLink.fromMap(e))
          .toList(),
      cardName: data['cardName'],
      suffix: data['suffix'],
      firstName: data['firstName'],
      otherName: data['otherName'],
      lastName: data['lastName'],
      designation: data['designation'],
      testimonials: data['testimonials'],
      videoUrl: data['videoUrl'],
      cardPictureUrl: data['cardPictureUrl'],
      cardCoverUrl: data['cardCoverUrl'],
      cardColor: data['cardColor'],
      active: data['active'],
      createdAt: data['createdAt'] != null
          ? DateTime.tryParse(data['createdAt'])
          : null,
      updatedAt: data['updatedAt'] != null
          ? DateTime.tryParse(data['updatedAt'])
          : null,
      v: data['__v'],
      catalogue: data['catelogue'],
    );
  }

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
        'catelogue': catalogue,
      };

  factory CardData.fromJson(String source) =>
      CardData.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}



@HiveType(typeId: 4)
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

@HiveType(typeId: 5)
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
