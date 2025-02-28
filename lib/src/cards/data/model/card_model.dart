import 'dart:convert';

class CardModel {
  final String? cardType;
  final String? ownerId;
  final String? cardName;
  final String? suffix;
  final String? firstName;
  final String? lastName;
  final String? middleName;
  final String? dateOfBirth;
  final String? designation;
  final String? notes;
  final String? primaryColor;
  final String? secondaryColor;
  final String? fontSize;
  final String? fontWeight;
  final String? fontStyle;
  final String? fontFamilyName;
  final String? organizationId;
  final String? email;
  final String? phone;
  final String? website;
  final String? address;
  final String? textColor;
  final List<SocialMediaLink>? socialMediaLinks;

  CardModel({
    this.cardType,
    this.ownerId,
    this.cardName,
    this.suffix,
    this.firstName,
    this.lastName,
    this.middleName,
    this.dateOfBirth,
    this.designation,
    this.notes,
    this.primaryColor,
    this.secondaryColor,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.fontFamilyName,
    this.organizationId,
    this.email,
    this.phone,
    this.website,
    this.address,
    this.textColor,
    this.socialMediaLinks,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      cardType: json['cardType'],
      ownerId: json['ownerId'],
      cardName: json['cardName'],
      suffix: json['suffix'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      middleName: json['middleName'],
      dateOfBirth: json['dateOfBirth'],
      designation: json['designation'],
      notes: json['notes'],
      primaryColor: json['primaryColor'],
      secondaryColor: json['secondaryColor'],
      fontSize: json['fontSize'],
      fontWeight: json['fontWeight'],
      fontStyle: json['fontStyle'],
      fontFamilyName: json['fontFamilyName'],
      organizationId: json['organizationId'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
      address: json['address'],
      textColor: json['textColor'],
      socialMediaLinks: (json['socialMediaLinks'] as List<dynamic>?)
          ?.map((e) => SocialMediaLink.fromJson(e))
          .toList(),
    );
  }

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      cardType: map['cardType'],
      ownerId: map['ownerId'],
      cardName: map['cardName'],
      suffix: map['suffix'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      middleName: map['middleName'],
      dateOfBirth: map['dateOfBirth'],
      designation: map['designation'],
      notes: map['notes'],
      primaryColor: map['primaryColor'],
      secondaryColor: map['secondaryColor'],
      fontSize: map['fontSize'],
      fontWeight: map['fontWeight'],
      fontStyle: map['fontStyle'],
      fontFamilyName: map['fontFamilyName'],
      organizationId: map['organizationId'],
      email: map['email'],
      phone: map['phone'],
      website: map['website'],
      address: map['address'],
      textColor: map['textColor'],
      socialMediaLinks: (map['socialMediaLinks'] as List<dynamic>?)
          ?.map((e) => SocialMediaLink.fromMap(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cardType': cardType,
      'ownerId': ownerId,
      'cardName': cardName,
      'suffix': suffix,
      'firstName': firstName,
      'lastName': lastName,
      'middleName': middleName,
      'dateOfBirth': dateOfBirth,
      'designation': designation,
      'notes': notes,
      'primaryColor': primaryColor,
      'secondaryColor': secondaryColor,
      'fontSize': fontSize,
      'fontWeight': fontWeight,
      'fontStyle': fontStyle,
      'fontFamilyName': fontFamilyName,
      'organizationId': organizationId,
      'email': email,
      'phone': phone,
      'website': website,
      'address': address,
      'textColor': textColor,
      'socialMediaLinks': socialMediaLinks?.map((e) => e.toJson()).toList(),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'cardType': cardType,
      'ownerId': ownerId,
      'cardName': cardName,
      'suffix': suffix,
      'firstName': firstName,
      'lastName': lastName,
      'middleName': middleName,
      'dateOfBirth': dateOfBirth,
      'designation': designation,
      'notes': notes,
      'primaryColor': primaryColor,
      'secondaryColor': secondaryColor,
      'fontSize': fontSize,
      'fontWeight': fontWeight,
      'fontStyle': fontStyle,
      'fontFamilyName': fontFamilyName,
      'organizationId': organizationId,
      'email': email,
      'phone': phone,
      'website': website,
      'address': address,
      'textColor': textColor,
      'socialMediaLinks': socialMediaLinks?.map((e) => e.toMap()).toList(),
    };
  }
}

class SocialMediaLink {
  final Media? media;
  final String? username;
  final bool? active;

  SocialMediaLink({
    this.media,
    this.username,
    this.active,
  });

  factory SocialMediaLink.fromJson(Map<String, dynamic> json) {
    return SocialMediaLink(
      media: json['media'] != null ? Media.fromJson(json['media']) : null,
      username: json['username'],
      active: json['active'],
    );
  }

  factory SocialMediaLink.fromMap(Map<String, dynamic> map) {
    return SocialMediaLink(
      media: map['media'] != null ? Media.fromMap(map['media']) : null,
      username: map['username'],
      active: map['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'media': media?.toJson(),
      'username': username,
      'active': active,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'media': media?.toMap(),
      'username': username,
      'active': active,
    };
  }
}

class Media {
  final String? iconUrl;
  final String? name;
  final String? type;
  final String? link;

  Media({
    this.iconUrl,
    this.name,
    this.type,
    this.link,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      iconUrl: json['iconUrl'],
      name: json['name'],
      type: json['type'],
      link: json['link'],
    );
  }

  factory Media.fromMap(Map<String, dynamic> map) {
    return Media(
      iconUrl: map['iconUrl'],
      name: map['name'],
      type: map['type'],
      link: map['link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iconUrl': iconUrl,
      'name': name,
      'type': type,
      'link': link,
    };
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

// class OrganizationInfo {
//   final String organizationId;
//   final String organizationName;

//   OrganizationInfo({
//     required this.organizationId,
//     required this.organizationName,
//   });

//   factory OrganizationInfo.fromJson(Map<String, dynamic> json) {
//     return OrganizationInfo(
//       organizationId: json['organizationId'],
//       organizationName: json['organizationName'],
//     );
//   }

//   factory OrganizationInfo.fromMap(Map<String, dynamic> map) {
//     return OrganizationInfo(
//       organizationId: map['organizationId'],
//       organizationName: map['organizationName'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'organizationId': organizationId,
//       'organizationName': organizationName,
//     };
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'organizationId': organizationId,
//       'organizationName': organizationName,
//     };
//   }
// }
