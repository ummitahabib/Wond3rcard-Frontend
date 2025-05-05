
class CardModel {
  final String id;
  final String cardType;
  final String creatorId;
  final String ownerId;
  final String cardName;
  final String firstName;
  final String lastName;
  final String? otherName;
  final String? prefix;
  final String? pronoun;
  final String? designation;
  final bool active;
  final String? videoUrl;
  final String? cardPictureUrl;
  final String? cardCoverUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final CardStyle cardStyle;
  final OrganizationInfo organizationInfo;
  final ContactInfo contactInfo;
  final List<dynamic> socialMediaLinks;
  final List<dynamic> testimonials;
  final List<dynamic> catalogue;
  final List<dynamic> sharedWith;

  CardModel({
    required this.id,
    required this.cardType,
    required this.creatorId,
    required this.ownerId,
    required this.cardName,
    required this.firstName,
    required this.lastName,
    this.otherName,
    this.prefix,
    this.pronoun,
    this.designation,
    required this.active,
    this.videoUrl,
    this.cardPictureUrl,
    this.cardCoverUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.cardStyle,
    required this.organizationInfo,
    required this.contactInfo,
    required this.socialMediaLinks,
    required this.testimonials,
    required this.catalogue,
    required this.sharedWith,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['_id'],
      cardType: json['cardType'],
      creatorId: json['creatorId'],
      ownerId: json['ownerId'],
      cardName: json['cardName'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      otherName: json['otherName'],
      prefix: json['prefix'],
      pronoun: json['pronoun'],
      designation: json['designation'],
      active: json['active'],
      videoUrl: json['videoUrl'],
      cardPictureUrl: json['cardPictureUrl'],
      cardCoverUrl: json['cardCoverUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      cardStyle: CardStyle.fromJson(json['cardStyle']),
      organizationInfo: OrganizationInfo.fromJson(json['organizationInfo']),
      contactInfo: ContactInfo.fromJson(json['contactInfo']),
      socialMediaLinks: json['socialMediaLinks'] ?? [],
      testimonials: json['testimonials'] ?? [],
      catalogue: json['catelogue'] ?? [],
      sharedWith: json['sharedWith'] ?? [],
    );
  }

  static List<CardModel> fromPayload(dynamic payload) {
    if (payload is Map<String, dynamic> && payload.containsKey('cards')) {
      return (payload['cards'] as List)
          .map((cardJson) => CardModel.fromJson(cardJson))
          .toList();
    }
    return [];
  }
}

class CardStyle {
  final String fontSize;
  final String fontStyle;
  final String fontWeight;
  final String textAlign;
  final String textColor;
  final String borderStyle;
  final String borderColor;
  final String borderWidth;
  final String borderRadius;
  final String padding;
  final String margin;
  final String orientation;
  final String alignment;
  final String boxShadow;
  final String primaryColor;
  final String secondaryColor;

  CardStyle({
    required this.fontSize,
    required this.fontStyle,
    required this.fontWeight,
    required this.textAlign,
    required this.textColor,
    required this.borderStyle,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.padding,
    required this.margin,
    required this.orientation,
    required this.alignment,
    required this.boxShadow,
    required this.primaryColor,
    required this.secondaryColor,
  });

  factory CardStyle.fromJson(Map<String, dynamic> json) {
    return CardStyle(
      fontSize: json['fontSize'],
      fontStyle: json['fontStyle'],
      fontWeight: json['fontWeight'],
      textAlign: json['textAlign'],
      textColor: json['textColor'],
      borderStyle: json['borderStyle'],
      borderColor: json['borderColor'],
      borderWidth: json['borderWidth'],
      borderRadius: json['borderRadius'],
      padding: json['padding'],
      margin: json['margin'],
      orientation: json['orientation'],
      alignment: json['alignment'],
      boxShadow: json['boxShadow'],
      primaryColor: json['primaryColor'],
      secondaryColor: json['secondaryColor'],
    );
  }
}

class OrganizationInfo {
  final String? organizationId;
  final String? organizationName;

  OrganizationInfo({this.organizationId, this.organizationName});

  factory OrganizationInfo.fromJson(Map<String, dynamic> json) {
    return OrganizationInfo(
      organizationId: json['organizationId'],
      organizationName: json['organizationName'],
    );
  }
}

class ContactInfo {
  final String email;
  final List<dynamic> emailType;
  final String phone;
  final String? website;
  final List<dynamic> addresses;

  ContactInfo({
    required this.email,
    required this.emailType,
    required this.phone,
    this.website,
    required this.addresses,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      email: json['email'],
      emailType: json['emailType'] ?? [],
      phone: json['phone'],
      website: json['website'],
      addresses: json['addresses'] ?? [],
    );
  }
}
