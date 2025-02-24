class GetCardsResponse {
  final CardStyle cardStyle;
  final OrganizationInfo organizationInfo;
  final ContactInfo contactInfo;
  final String id;
  final String cardType;
  final String creatorId;
  final String ownerId;
  final TextStyle textStyle;
  final CardDesign cardDesign;
  final CardLayout cardLayout;
  final List<SocialMediaLink> socialMediaLinks;
  final String cardName;
  final String suffix;
  final String firstName;
  final String otherName;
  final String lastName;
  final String designation;
  final List<String> testimonials;
  final String videoUrl;
  final String cardPictureUrl;
  final String cardCoverUrl;
  final String cardColor;
  final bool active;
  final String createdAt;
  final String updatedAt;
  final int v;
  final List<String> catelogue;

  GetCardsResponse({
    required this.cardStyle,
    required this.organizationInfo,
    required this.contactInfo,
    required this.id,
    required this.cardType,
    required this.creatorId,
    required this.ownerId,
    required this.textStyle,
    required this.cardDesign,
    required this.cardLayout,
    required this.socialMediaLinks,
    required this.cardName,
    required this.suffix,
    required this.firstName,
    required this.otherName,
    required this.lastName,
    required this.designation,
    required this.testimonials,
    required this.videoUrl,
    required this.cardPictureUrl,
    required this.cardCoverUrl,
    required this.cardColor,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.catelogue,
  });

  factory GetCardsResponse.fromJson(Map<String, dynamic> json) {
    return GetCardsResponse(
      cardStyle: CardStyle.fromJson(json['cardStyle']),
      organizationInfo: OrganizationInfo.fromJson(json['organizationInfo']),
      contactInfo: ContactInfo.fromJson(json['contactInfo']),
      id: json['_id'],
      cardType: json['cardType'],
      creatorId: json['creatorId'],
      ownerId: json['ownerId'],
      textStyle: TextStyle.fromJson(json['textStyle']),
      cardDesign: CardDesign.fromJson(json['cardDesign']),
      cardLayout: CardLayout.fromJson(json['cardLayout']),
      socialMediaLinks: List<SocialMediaLink>.from(json['socialMediaLinks']
          .map((link) => SocialMediaLink.fromJson(link))),
      cardName: json['cardName'],
      suffix: json['suffix'],
      firstName: json['firstName'],
      otherName: json['otherName'],
      lastName: json['lastName'],
      designation: json['designation'],
      testimonials: List<String>.from(json['testimonials']),
      videoUrl: json['videoUrl'],
      cardPictureUrl: json['cardPictureUrl'],
      cardCoverUrl: json['cardCoverUrl'],
      cardColor: json['cardColor'],
      active: json['active'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      catelogue: List<String>.from(json['catelogue']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cardStyle': cardStyle.toJson(),
      'organizationInfo': organizationInfo.toJson(),
      'contactInfo': contactInfo.toJson(),
      '_id': id,
      'cardType': cardType,
      'creatorId': creatorId,
      'ownerId': ownerId,
      'textStyle': textStyle.toJson(),
      'cardDesign': cardDesign.toJson(),
      'cardLayout': cardLayout.toJson(),
      'socialMediaLinks':
          socialMediaLinks.map((link) => link.toJson()).toList(),
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
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
      'catelogue': catelogue,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'fontSize': fontSize,
      'fontStyle': fontStyle,
      'fontWeight': fontWeight,
      'textAlign': textAlign,
      'textColor': textColor,
      'borderStyle': borderStyle,
      'borderColor': borderColor,
      'borderWidth': borderWidth,
      'borderRadius': borderRadius,
      'padding': padding,
      'margin': margin,
      'orientation': orientation,
      'alignment': alignment,
      'boxShadow': boxShadow,
      'primaryColor': primaryColor,
      'secondaryColor': secondaryColor,
    };
  }
}

class OrganizationInfo {
  final String organizationName;

  OrganizationInfo({
    required this.organizationName,
  });

  factory OrganizationInfo.fromJson(Map<String, dynamic> json) {
    return OrganizationInfo(
      organizationName: json['organizationName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'organizationName': organizationName,
    };
  }
}

class ContactInfo {
  final List<String> emailType;
  final String email;
  final String phone;
  final String website;
  final String address;
  final List<String> addresses;

  ContactInfo({
    required this.emailType,
    required this.email,
    required this.phone,
    required this.website,
    required this.address,
    required this.addresses,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      emailType: List<String>.from(json['emailType']),
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
      address: json['address'],
      addresses: List<String>.from(json['addresses']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emailType': emailType,
      'email': email,
      'phone': phone,
      'website': website,
      'address': address,
      'addresses': addresses,
    };
  }
}

class TextStyle {
  final String fontSize;
  final String fontStyle;
  final String fontWeight;
  final String textAlign;
  final String textColor;

  TextStyle({
    required this.fontSize,
    required this.fontStyle,
    required this.fontWeight,
    required this.textAlign,
    required this.textColor,
  });

  factory TextStyle.fromJson(Map<String, dynamic> json) {
    return TextStyle(
      fontSize: json['fontSize'],
      fontStyle: json['fontStyle'],
      fontWeight: json['fontWeight'],
      textAlign: json['textAlign'],
      textColor: json['textColor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fontSize': fontSize,
      'fontStyle': fontStyle,
      'fontWeight': fontWeight,
      'textAlign': textAlign,
      'textColor': textColor,
    };
  }
}

class CardDesign {
  final String backgroundColor;
  final String backgroundImage;
  final String borderStyle;
  final String borderColor;
  final String borderWidth;
  final String borderRadius;
  final String boxShadow;

  CardDesign({
    required this.backgroundColor,
    required this.backgroundImage,
    required this.borderStyle,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.boxShadow,
  });

  factory CardDesign.fromJson(Map<String, dynamic> json) {
    return CardDesign(
      backgroundColor: json['backgroundColor'],
      backgroundImage: json['backgroundImage'],
      borderStyle: json['borderStyle'],
      borderColor: json['borderColor'],
      borderWidth: json['borderWidth'],
      borderRadius: json['borderRadius'],
      boxShadow: json['boxShadow'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'backgroundColor': backgroundColor,
      'backgroundImage': backgroundImage,
      'borderStyle': borderStyle,
      'borderColor': borderColor,
      'borderWidth': borderWidth,
      'borderRadius': borderRadius,
      'boxShadow': boxShadow,
    };
  }
}

class CardLayout {
  final String padding;
  final String margin;
  final String layoutOrientation;

  CardLayout({
    required this.padding,
    required this.margin,
    required this.layoutOrientation,
  });

  factory CardLayout.fromJson(Map<String, dynamic> json) {
    return CardLayout(
      padding: json['padding'],
      margin: json['margin'],
      layoutOrientation: json['layoutOrientation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'padding': padding,
      'margin': margin,
      'layoutOrientation': layoutOrientation,
    };
  }
}

class SocialMediaLink {
  final String username;
  final bool active;
  final String id;
  final String linkedin;
  final String twitter;
  final String facebook;
  final String instagram;
  final String tiktok;
  final String github;
  final String youtube;
  final List<String> customLinks;

  SocialMediaLink({
    required this.username,
    required this.active,
    required this.id,
    required this.linkedin,
    required this.twitter,
    required this.facebook,
    required this.instagram,
    required this.tiktok,
    required this.github,
    required this.youtube,
    required this.customLinks,
  });

  factory SocialMediaLink.fromJson(Map<String, dynamic> json) {
    return SocialMediaLink(
      username: json['username'],
      active: json['active'],
      id: json['_id'],
      linkedin: json['linkedin'],
      twitter: json['twitter'],
      facebook: json['facebook'],
      instagram: json['instagram'],
      tiktok: json['tiktok'],
      github: json['github'],
      youtube: json['youtube'],
      customLinks: List<String>.from(json['customLinks']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'active': active,
      '_id': id,
      'linkedin': linkedin,
      'twitter': twitter,
      'facebook': facebook,
      'instagram': instagram,
      'tiktok': tiktok,
      'github': github,
      'youtube': youtube,
      'customLinks': customLinks,
    };
  }
}
