import 'package:wond3rcard/src/cards/data/model/card_model.dart';

import 'card_design.dart';
import 'card_layout.dart';
import 'card_style.dart';
import 'contact_info.dart';
import 'organization_info.dart';
import 'social_media_link.dart';
import 'text_style.dart';

class Card {
  CardStyle? cardStyle;
  OrganizationInfo? organizationInfo;
  ContactInfo? contactInfo;
  String? prefix;
  String? pronoun;
  String? id;
  String? cardType;
  String? creatorId;
  String? ownerId;
  TextStyle? textStyle;
  CardDesign? cardDesign;
  CardLayout? cardLayout;
  List<SocialMediaLink>? socialMediaLinks;
  String? cardName;
  String? suffix;
  String? firstName;
  String? otherName;
  String? lastName;
  String? designation;
  List<dynamic>? testimonials;
  String? videoUrl;
  String? cardPictureUrl;
  String? cardCoverUrl;
  String? cardColor;
  bool? active;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
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

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        cardStyle: json['cardStyle'] == null
            ? null
            : CardStyle.fromJson(json['cardStyle'] as Map<String, dynamic>),
        organizationInfo: json['organizationInfo'] == null
            ? null
            : OrganizationInfo.fromJson(
                json['organizationInfo'] as Map<String, dynamic>),
        contactInfo: json['contactInfo'] == null
            ? null
            : ContactInfo.fromJson(json['contactInfo'] as Map<String, dynamic>),
        prefix: json['prefix'] as String?,
        pronoun: json['pronoun'] as String?,
        id: json['_id'] as String?,
        cardType: json['cardType'] as String?,
        creatorId: json['creatorId'] as String?,
        ownerId: json['ownerId'] as String?,
        textStyle: json['textStyle'] == null
            ? null
            : TextStyle.fromJson(json['textStyle'] as Map<String, dynamic>),
        cardDesign: json['cardDesign'] == null
            ? null
            : CardDesign.fromJson(json['cardDesign'] as Map<String, dynamic>),
        cardLayout: json['cardLayout'] == null
            ? null
            : CardLayout.fromJson(json['cardLayout'] as Map<String, dynamic>),
        socialMediaLinks: (json['socialMediaLinks'] as List<dynamic>?)
            ?.map((e) => SocialMediaLink.fromJson(e as Map<String, dynamic>))
            .toList(),
        cardName: json['cardName'] as String?,
        suffix: json['suffix'] as String?,
        firstName: json['firstName'] as String?,
        otherName: json['otherName'] as String?,
        lastName: json['lastName'] as String?,
        designation: json['designation'] as String?,
        testimonials: json['testimonials'] as List<dynamic>?,
        videoUrl: json['videoUrl'] as String?,
        cardPictureUrl: json['cardPictureUrl'] as String?,
        cardCoverUrl: json['cardCoverUrl'] as String?,
        cardColor: json['cardColor'] as String?,
        active: json['active'] as bool?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        v: json['__v'] as int?,
        catelogue: json['catelogue'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'cardStyle': cardStyle?.toJson(),
        'organizationInfo': organizationInfo?.toJson(),
        'contactInfo': contactInfo?.toJson(),
        'prefix': prefix,
        'pronoun': pronoun,
        '_id': id,
        'cardType': cardType,
        'creatorId': creatorId,
        'ownerId': ownerId,
        'textStyle': textStyle?.toJson(),
        'cardDesign': cardDesign?.toJson(),
        'cardLayout': cardLayout?.toJson(),
        'socialMediaLinks': socialMediaLinks?.map((e) => e.toJson()).toList(),
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
}
