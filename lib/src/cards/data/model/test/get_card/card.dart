// import 'dart:convert';

// import 'package:collection/collection.dart';
// import 'package:wond3rcard/src/cards/data/model/card_model.dart';

// import 'card_design.dart';
// import 'card_layout.dart';
// import 'card_style.dart';
// import 'contact_info.dart';
// import 'organization_info.dart';
// import 'social_media_link.dart';
// import 'text_style.dart';

// class Card {
//   CardStyle? cardStyle;
//   OrganizationInfo? organizationInfo;
//   ContactInfo? contactInfo;
//   String? prefix;
//   String? pronoun;
//   String? id;
//   String? cardType;
//   String? creatorId;
//   String? ownerId;
//   TextStyle? textStyle;
//   CardDesign? cardDesign;
//   CardLayout? cardLayout;
//   List<SocialMediaLink>? socialMediaLinks;
//   String? cardName;
//   String? suffix;
//   String? firstName;
//   String? otherName;
//   String? lastName;
//   String? designation;
//   List<dynamic>? testimonials;
//   String? videoUrl;
//   String? cardPictureUrl;
//   String? cardCoverUrl;
//   String? cardColor;
//   bool? active;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? v;
//   List<dynamic>? catelogue;

//   Card({
//     this.cardStyle,
//     this.organizationInfo,
//     this.contactInfo,
//     this.prefix,
//     this.pronoun,
//     this.id,
//     this.cardType,
//     this.creatorId,
//     this.ownerId,
//     this.textStyle,
//     this.cardDesign,
//     this.cardLayout,
//     this.socialMediaLinks,
//     this.cardName,
//     this.suffix,
//     this.firstName,
//     this.otherName,
//     this.lastName,
//     this.designation,
//     this.testimonials,
//     this.videoUrl,
//     this.cardPictureUrl,
//     this.cardCoverUrl,
//     this.cardColor,
//     this.active,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//     this.catelogue,
//   });

//   @override
//   String toString() {
//     return 'Card(cardStyle: $cardStyle, organizationInfo: $organizationInfo, contactInfo: $contactInfo, prefix: $prefix, pronoun: $pronoun, id: $id, cardType: $cardType, creatorId: $creatorId, ownerId: $ownerId, textStyle: $textStyle, cardDesign: $cardDesign, cardLayout: $cardLayout, socialMediaLinks: $socialMediaLinks, cardName: $cardName, suffix: $suffix, firstName: $firstName, otherName: $otherName, lastName: $lastName, designation: $designation, testimonials: $testimonials, videoUrl: $videoUrl, cardPictureUrl: $cardPictureUrl, cardCoverUrl: $cardCoverUrl, cardColor: $cardColor, active: $active, createdAt: $createdAt, updatedAt: $updatedAt, v: $v, catelogue: $catelogue)';
//   }

//   factory Card.fromMap(Map<String, dynamic> data) => Card(
//         cardStyle: data['cardStyle'] == null
//             ? null
//             : CardStyle.fromMap(data['cardStyle'] as Map<String, dynamic>),
//         organizationInfo: data['organizationInfo'] == null
//             ? null
//             : OrganizationInfo.fromMap(
//                 data['organizationInfo'] as Map<String, dynamic>),
//         contactInfo: data['contactInfo'] == null
//             ? null
//             : ContactInfo.fromMap(data['contactInfo'] as Map<String, dynamic>),
//         prefix: data['prefix'] as String?,
//         pronoun: data['pronoun'] as String?,
//         id: data['_id'] as String?,
//         cardType: data['cardType'] as String?,
//         creatorId: data['creatorId'] as String?,
//         ownerId: data['ownerId'] as String?,
//         textStyle: data['textStyle'] == null
//             ? null
//             : TextStyle.fromMap(data['textStyle'] as Map<String, dynamic>),
//         cardDesign: data['cardDesign'] == null
//             ? null
//             : CardDesign.fromMap(data['cardDesign'] as Map<String, dynamic>),
//         cardLayout: data['cardLayout'] == null
//             ? null
//             : CardLayout.fromMap(data['cardLayout'] as Map<String, dynamic>),
//         socialMediaLinks: (data['socialMediaLinks'] as List<dynamic>?)
//             ?.map((e) => SocialMediaLink.fromMap(e as Map<String, dynamic>))
//             .toList(),
//         cardName: data['cardName'] as String?,
//         suffix: data['suffix'] as String?,
//         firstName: data['firstName'] as String?,
//         otherName: data['otherName'] as String?,
//         lastName: data['lastName'] as String?,
//         designation: data['designation'] as String?,
//         testimonials: data['testimonials'] as List<dynamic>?,
//         videoUrl: data['videoUrl'] as String?,
//         cardPictureUrl: data['cardPictureUrl'] as String?,
//         cardCoverUrl: data['cardCoverUrl'] as String?,
//         cardColor: data['cardColor'] as String?,
//         active: data['active'] as bool?,
//         createdAt: data['createdAt'] == null
//             ? null
//             : DateTime.parse(data['createdAt'] as String),
//         updatedAt: data['updatedAt'] == null
//             ? null
//             : DateTime.parse(data['updatedAt'] as String),
//         v: data['__v'] as int?,
//         catelogue: data['catelogue'] as List<dynamic>?,
//       );

//   Map<String, dynamic> toMap() => {
//         'cardStyle': cardStyle?.toMap(),
//         'organizationInfo': organizationInfo?.toMap(),
//         'contactInfo': contactInfo?.toMap(),
//         'prefix': prefix,
//         'pronoun': pronoun,
//         '_id': id,
//         'cardType': cardType,
//         'creatorId': creatorId,
//         'ownerId': ownerId,
//         'textStyle': textStyle?.toMap(),
//         'cardDesign': cardDesign?.toMap(),
//         'cardLayout': cardLayout?.toMap(),
//         'socialMediaLinks': socialMediaLinks?.map((e) => e.toMap()).toList(),
//         'cardName': cardName,
//         'suffix': suffix,
//         'firstName': firstName,
//         'otherName': otherName,
//         'lastName': lastName,
//         'designation': designation,
//         'testimonials': testimonials,
//         'videoUrl': videoUrl,
//         'cardPictureUrl': cardPictureUrl,
//         'cardCoverUrl': cardCoverUrl,
//         'cardColor': cardColor,
//         'active': active,
//         'createdAt': createdAt?.toIso8601String(),
//         'updatedAt': updatedAt?.toIso8601String(),
//         '__v': v,
//         'catelogue': catelogue,
//       };

//   /// `dart:convert`
//   ///
//   /// Parses the string and returns the resulting Json object as [Card].
//   factory Card.fromJson(String data) {
//     return Card.fromMap(json.decode(data) as Map<String, dynamic>);
//   }

//   /// `dart:convert`
//   ///
//   /// Converts [Card] to a JSON string.
//   String toJson() => json.encode(toMap());

//   Card copyWith({
//     CardStyle? cardStyle,
//     OrganizationInfo? organizationInfo,
//     ContactInfo? contactInfo,
//     String? prefix,
//     String? pronoun,
//     String? id,
//     String? cardType,
//     String? creatorId,
//     String? ownerId,
//     TextStyle? textStyle,
//     CardDesign? cardDesign,
//     CardLayout? cardLayout,
//     List<SocialMediaLink>? socialMediaLinks,
//     String? cardName,
//     String? suffix,
//     String? firstName,
//     String? otherName,
//     String? lastName,
//     String? designation,
//     List<dynamic>? testimonials,
//     String? videoUrl,
//     String? cardPictureUrl,
//     String? cardCoverUrl,
//     String? cardColor,
//     bool? active,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     int? v,
//     List<dynamic>? catelogue,
//   }) {
//     return Card(
//       cardStyle: cardStyle ?? this.cardStyle,
//       organizationInfo: organizationInfo ?? this.organizationInfo,
//       contactInfo: contactInfo ?? this.contactInfo,
//       prefix: prefix ?? this.prefix,
//       pronoun: pronoun ?? this.pronoun,
//       id: id ?? this.id,
//       cardType: cardType ?? this.cardType,
//       creatorId: creatorId ?? this.creatorId,
//       ownerId: ownerId ?? this.ownerId,
//       textStyle: textStyle ?? this.textStyle,
//       cardDesign: cardDesign ?? this.cardDesign,
//       cardLayout: cardLayout ?? this.cardLayout,
//       socialMediaLinks: socialMediaLinks ?? this.socialMediaLinks,
//       cardName: cardName ?? this.cardName,
//       suffix: suffix ?? this.suffix,
//       firstName: firstName ?? this.firstName,
//       otherName: otherName ?? this.otherName,
//       lastName: lastName ?? this.lastName,
//       designation: designation ?? this.designation,
//       testimonials: testimonials ?? this.testimonials,
//       videoUrl: videoUrl ?? this.videoUrl,
//       cardPictureUrl: cardPictureUrl ?? this.cardPictureUrl,
//       cardCoverUrl: cardCoverUrl ?? this.cardCoverUrl,
//       cardColor: cardColor ?? this.cardColor,
//       active: active ?? this.active,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//       v: v ?? this.v,
//       catelogue: catelogue ?? this.catelogue,
//     );
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(other, this)) return true;
//     if (other is! Card) return false;
//     final mapEquals = const DeepCollectionEquality().equals;
//     return mapEquals(other.toMap(), toMap());
//   }

//   @override
//   int get hashCode =>
//       cardStyle.hashCode ^
//       organizationInfo.hashCode ^
//       contactInfo.hashCode ^
//       prefix.hashCode ^
//       pronoun.hashCode ^
//       id.hashCode ^
//       cardType.hashCode ^
//       creatorId.hashCode ^
//       ownerId.hashCode ^
//       textStyle.hashCode ^
//       cardDesign.hashCode ^
//       cardLayout.hashCode ^
//       socialMediaLinks.hashCode ^
//       cardName.hashCode ^
//       suffix.hashCode ^
//       firstName.hashCode ^
//       otherName.hashCode ^
//       lastName.hashCode ^
//       designation.hashCode ^
//       testimonials.hashCode ^
//       videoUrl.hashCode ^
//       cardPictureUrl.hashCode ^
//       cardCoverUrl.hashCode ^
//       cardColor.hashCode ^
//       active.hashCode ^
//       createdAt.hashCode ^
//       updatedAt.hashCode ^
//       v.hashCode ^
//       catelogue.hashCode;
// }


// class SocialMediaLink {
//   final Media? media;
//   final String? username;
//   final bool? active;

//   SocialMediaLink({
//     this.media,
//     this.username,
//     this.active,
//   });

//   factory SocialMediaLink.fromJson(Map<String, dynamic> json) {
//     return SocialMediaLink(
//       media: json['media'] != null ? Media.fromJson(json['media']) : null,
//       username: json['username'],
//       active: json['active'],
//     );
//   }

//   factory SocialMediaLink.fromMap(Map<String, dynamic> map) {
//     return SocialMediaLink(
//       media: map['media'] != null ? Media.fromMap(map['media']) : null,
//       username: map['username'],
//       active: map['active'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'media': media?.toJson(),
//       'username': username,
//       'active': active,
//     };
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'media': media?.toMap(),
//       'username': username,
//       'active': active,
//     };
//   }
// }

// class Media {
//   final String? iconUrl;
//   final String? name;
//   final String? type;
//   final String? link;

//   Media({
//     this.iconUrl,
//     this.name,
//     this.type,
//     this.link,
//   });

//   factory Media.fromJson(Map<String, dynamic> json) {
//     return Media(
//       iconUrl: json['iconUrl'],
//       name: json['name'],
//       type: json['type'],
//       link: json['link'],
//     );
//   }

//   factory Media.fromMap(Map<String, dynamic> map) {
//     return Media(
//       iconUrl: map['iconUrl'],
//       name: map['name'],
//       type: map['type'],
//       link: map['link'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'iconUrl': iconUrl,
//       'name': name,
//       'type': type,
//       'link': link,
//     };
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'iconUrl': iconUrl,
//       'name': name,
//       'type': type,
//       'link': link,
//     };
//   }
// }