// import 'dart:convert';

// class CardModel {
//   final String? cardType;
//   final String? ownerId;
//   final String? cardName;
//   final String? suffix;
//   final String? firstName;
//   final String? lastName;
//   final String? middleName;
//   final String? dateOfBirth;
//   final String? designation;
//   final String? notes;
//   final String? primaryColor;
//   final String? secondaryColor;
//   final String? fontSize;
//   final String? fontWeight;
//   final String? fontStyle;
//   final String? fontFamilyName;
//   final String? organizationId;
//   final String? email;
//   final String? phone;
//   final String? website;
//   final String? address;
//   final String? textColor;
//   final List<SocialMediaLink>? socialMediaLinks;

//   CardModel({
//     this.cardType,
//     this.ownerId,
//     this.cardName,
//     this.suffix,
//     this.firstName,
//     this.lastName,
//     this.middleName,
//     this.dateOfBirth,
//     this.designation,
//     this.notes,
//     this.primaryColor,
//     this.secondaryColor,
//     this.fontSize,
//     this.fontWeight,
//     this.fontStyle,
//     this.fontFamilyName,
//     this.organizationId,
//     this.email,
//     this.phone,
//     this.website,
//     this.address,
//     this.textColor,
//     this.socialMediaLinks,
//   });

//   factory CardModel.fromJson(Map<String, dynamic> json) {
//     return CardModel(
//       cardType: json['cardType'],
//       ownerId: json['ownerId'],
//       cardName: json['cardName'],
//       suffix: json['suffix'],
//       firstName: json['firstName'],
//       lastName: json['lastName'],
//       middleName: json['middleName'],
//       dateOfBirth: json['dateOfBirth'],
//       designation: json['designation'],
//       notes: json['notes'],
//       primaryColor: json['primaryColor'],
//       secondaryColor: json['secondaryColor'],
//       fontSize: json['fontSize'],
//       fontWeight: json['fontWeight'],
//       fontStyle: json['fontStyle'],
//       fontFamilyName: json['fontFamilyName'],
//       organizationId: json['organizationId'],
//       email: json['email'],
//       phone: json['phone'],
//       website: json['website'],
//       address: json['address'],
//       textColor: json['textColor'],
//       socialMediaLinks: (json['socialMediaLinks'] as List<dynamic>?)
//           ?.map((e) => SocialMediaLink.fromJson(e))
//           .toList(),
//     );
//   }

//   factory CardModel.fromMap(Map<String, dynamic> map) {
//     return CardModel(
//       cardType: map['cardType'],
//       ownerId: map['ownerId'],
//       cardName: map['cardName'],
//       suffix: map['suffix'],
//       firstName: map['firstName'],
//       lastName: map['lastName'],
//       middleName: map['middleName'],
//       dateOfBirth: map['dateOfBirth'],
//       designation: map['designation'],
//       notes: map['notes'],
//       primaryColor: map['primaryColor'],
//       secondaryColor: map['secondaryColor'],
//       fontSize: map['fontSize'],
//       fontWeight: map['fontWeight'],
//       fontStyle: map['fontStyle'],
//       fontFamilyName: map['fontFamilyName'],
//       organizationId: map['organizationId'],
//       email: map['email'],
//       phone: map['phone'],
//       website: map['website'],
//       address: map['address'],
//       textColor: map['textColor'],
//       socialMediaLinks: (map['socialMediaLinks'] as List<dynamic>?)
//           ?.map((e) => SocialMediaLink.fromMap(e))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'cardType': cardType,
//       'ownerId': ownerId,
//       'cardName': cardName,
//       'suffix': suffix,
//       'firstName': firstName,
//       'lastName': lastName,
//       'middleName': middleName,
//       'dateOfBirth': dateOfBirth,
//       'designation': designation,
//       'notes': notes,
//       'primaryColor': primaryColor,
//       'secondaryColor': secondaryColor,
//       'fontSize': fontSize,
//       'fontWeight': fontWeight,
//       'fontStyle': fontStyle,
//       'fontFamilyName': fontFamilyName,
//       'organizationId': organizationId,
//       'email': email,
//       'phone': phone,
//       'website': website,
//       'address': address,
//       'textColor': textColor,
//       'socialMediaLinks': socialMediaLinks?.map((e) => e.toJson()).toList(),
//     };
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'cardType': cardType,
//       'ownerId': ownerId,
//       'cardName': cardName,
//       'suffix': suffix,
//       'firstName': firstName,
//       'lastName': lastName,
//       'middleName': middleName,
//       'dateOfBirth': dateOfBirth,
//       'designation': designation,
//       'notes': notes,
//       'primaryColor': primaryColor,
//       'secondaryColor': secondaryColor,
//       'fontSize': fontSize,
//       'fontWeight': fontWeight,
//       'fontStyle': fontStyle,
//       'fontFamilyName': fontFamilyName,
//       'organizationId': organizationId,
//       'email': email,
//       'phone': phone,
//       'website': website,
//       'address': address,
//       'textColor': textColor,
//       'socialMediaLinks': socialMediaLinks?.map((e) => e.toMap()).toList(),
//     };
//   }
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

// // class OrganizationInfo {
// //   final String organizationId;
// //   final String organizationName;

// //   OrganizationInfo({
// //     required this.organizationId,
// //     required this.organizationName,
// //   });

// //   factory OrganizationInfo.fromJson(Map<String, dynamic> json) {
// //     return OrganizationInfo(
// //       organizationId: json['organizationId'],
// //       organizationName: json['organizationName'],
// //     );
// //   }

// //   factory OrganizationInfo.fromMap(Map<String, dynamic> map) {
// //     return OrganizationInfo(
// //       organizationId: map['organizationId'],
// //       organizationName: map['organizationName'],
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'organizationId': organizationId,
// //       'organizationName': organizationName,
// //     };
// //   }

// //   Map<String, dynamic> toMap() {
// //     return {
// //       'organizationId': organizationId,
// //       'organizationName': organizationName,
// //     };
// //   }
// // }




// import 'dart:convert';

// class CardModel {
//   final String? cardType;
//   final String? ownerId;
//   final String? cardName;
//   final String? suffix;
//   final String? firstName;
//   final String? lastName;
//   final String? middleName;
//   final String? dateOfBirth;
//   final String? designation;
//   final String? notes;
//   final String? primaryColor;
//   final String? secondaryColor;
//   final String? fontSize;
//   final String? fontWeight;
//   final String? fontStyle;
//   final String? fontFamilyName;
//   final String? organizationId;
//   final String? email;
//   final String? phone;
//   final String? website;
//   final String? address;
//   final String? textColor;
//   List<Map<String, dynamic>> socialMediaLinks;
//   final String? cardPhoto;
//   final String? cardCoverPhoto;
//   final String? cardVideo;

//   CardModel({
//     required this.cardType,
//     required this.cardName,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.phone,
//     required this.website,
//     required this.address,
//    required this.ownerId,
//   required this.suffix,
//   required this.middleName,
//   required this.dateOfBirth,
//   required this.designation,
//   required this.notes,
//   required this.primaryColor,
//   required this.secondaryColor,
//   required this.fontSize,
//   required this.fontWeight,
//   required this.fontStyle,
//   required this.fontFamilyName,
//   required this.organizationId,
//   required this.textColor,
//   required this.socialMediaLinks,
//    this.cardPhoto,
//   this.cardCoverPhoto,
//   this.cardVideo,
//   });

//   Map<String, String> toFormData() {
//     return {
//       "cardType": cardType ?? '',
//       "cardName": cardName ?? '',
//       "firstName": firstName ?? '',
//       "lastName": lastName ?? '',
//       "ownerId": ownerId ?? '',
//       "suffix": suffix ?? '',
//       "email": email ?? '',
//       "phone": phone ?? '',
//       "website": website ?? '',
//       "address": address ?? '',
//       "middleName": middleName ?? '',
//       "dateOfBirth": dateOfBirth ?? '',
//       "designation": designation ?? '',
//       "notes": notes ?? '',
//       "primaryColor": primaryColor ?? '',
//       "secondaryColor": secondaryColor ?? '',
//       "fontSize": fontSize ?? '',
//       "fontWeight": fontWeight ?? '',
//       "fontStyle": fontStyle ?? '',
//       "fontFamilyName": fontFamilyName ?? '',
//       "organizationId": organizationId ?? '',
//       "textColor": textColor ?? '',
//       "socialMediaLinks": jsonEncode(socialMediaLinks),
//       "cardPhoto": cardPhoto ?? '',
//       "cardCoverPhoto": cardCoverPhoto ?? '',
//       "cardVideo": cardVideo ?? '',
//     };
//   }
// }

import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'; // for kIsWeb
import 'package:mime/mime.dart'; // To detect MIME types

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
  final List<Map<String, dynamic>> socialMediaLinks;

  // Files (Mobile)
  final File? cardPhoto;
  final File? cardCoverPhoto;
  final File? cardVideo;

  // Web-specific files (Uint8List)
  final Uint8List? webCardPhoto;
  final Uint8List? webCardCoverPhoto;
  final Uint8List? webCardVideo;

  CardModel({
    required this.cardType,
    required this.cardName,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.website,
    required this.address,
    required this.ownerId,
    required this.suffix,
    required this.middleName,
    required this.dateOfBirth,
    required this.designation,
    required this.notes,
    required this.primaryColor,
    required this.secondaryColor,
    required this.fontSize,
    required this.fontWeight,
    required this.fontStyle,
    required this.fontFamilyName,
    required this.organizationId,
    required this.textColor,
    required this.socialMediaLinks,
    this.cardPhoto,
    this.cardCoverPhoto,
    this.cardVideo,
    this.webCardPhoto,
    this.webCardCoverPhoto,
    this.webCardVideo,
  });

  /// Converts a file to a `MultipartFile` dynamically, keeping the correct format
  Future<MultipartFile?> _convertFile(File? file) async {
    if (file == null) return null;
    String? mimeType = lookupMimeType(file.path);
    String extension = mimeType?.split('/').last ?? 'jpg'; // Default to jpg
    return MultipartFile.fromFile(file.path, filename: 'file.$extension');
  }

  /// Converts Uint8List (Web) to `MultipartFile` dynamically
  MultipartFile? _convertWebFile(Uint8List? bytes, {String defaultExt = 'png'}) {
    if (bytes == null) return null;
    return MultipartFile.fromBytes(bytes, filename: 'file.$defaultExt');
  }

  /// Converts the model to Dio's `FormData`
  Future<FormData> toFormData() async {
    FormData formData = FormData.fromMap({
      "cardType": cardType ?? '',
      "cardName": cardName ?? '',
      "firstName": firstName ?? '',
      "lastName": lastName ?? '',
      "ownerId": ownerId ?? '',
      "suffix": suffix ?? '',
      "email": email ?? '',
      "phone": phone ?? '',
      "website": website ?? '',
      "address": address ?? '',
      "middleName": middleName ?? '',
      "dateOfBirth": dateOfBirth ?? '',
      "designation": designation ?? '',
      "notes": notes ?? '',
      "primaryColor": primaryColor ?? '',
      "secondaryColor": secondaryColor ?? '',
      "fontSize": fontSize ?? '',
      "fontWeight": fontWeight ?? '',
      "fontStyle": fontStyle ?? '',
      "fontFamilyName": fontFamilyName ?? '',
      "organizationId": organizationId ?? '',
      "textColor": textColor ?? '',
      "socialMediaLinks": jsonEncode(socialMediaLinks),
    });

    // **🔹 Attach files dynamically**
    if (kIsWeb) {
      // Web file uploads (Uint8List)
      _attachWebFile(formData, webCardPhoto, 'cardPhoto', 'png');
      _attachWebFile(formData, webCardCoverPhoto, 'cardCoverPhoto', 'png');
      _attachWebFile(formData, webCardVideo, 'cardVideo', 'mp4');
    } else {
      // Mobile file uploads (File)
      _attachMobileFile(formData, cardPhoto, 'cardPhoto');
      _attachMobileFile(formData, cardCoverPhoto, 'cardCoverPhoto');
      _attachMobileFile(formData, cardVideo, 'cardVideo');
    }

    return formData;
  }

  /// **Attaches a file dynamically for Mobile (File)**
  Future<void> _attachMobileFile(FormData formData, File? file, String fieldName) async {
    final MultipartFile? multipartFile = await _convertFile(file);
    if (multipartFile != null) {
      formData.files.add(MapEntry(fieldName, multipartFile));
    }
  }

  /// **Attaches a file dynamically for Web (Uint8List)**
  void _attachWebFile(FormData formData, Uint8List? bytes, String fieldName, String defaultExt) {
    final MultipartFile? multipartFile = _convertWebFile(bytes, defaultExt: defaultExt);
    if (multipartFile != null) {
      formData.files.add(MapEntry(fieldName, multipartFile));
    }
  }
}
