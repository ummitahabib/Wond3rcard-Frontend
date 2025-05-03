import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

import 'package:file_picker/file_picker.dart';

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

  final PlatformFile? cardPhoto;
  final PlatformFile? cardCoverPhoto;
  final PlatformFile? cardVideo;

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
  });

  Future<FormData> toFormData() async {
    final Map<String, dynamic> formMap = {
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
    };

    Future<MultipartFile?> _fileToMultipart(PlatformFile? file) async {
      if (file == null) return null;

      final mimeType = lookupMimeType(file.name);

      if (file.bytes != null) {
        return MultipartFile.fromBytes(
          file.bytes!,
          filename: file.name,
          contentType: MediaType.parse(mimeType ?? 'application/octet-stream'),
        );
      } else if (file.path != null) {
        return await MultipartFile.fromFile(
          file.path!,
          filename: file.name,
          contentType: MediaType.parse(mimeType ?? 'application/octet-stream'),
        );
      }
      return null;
    }

    final photo = await _fileToMultipart(cardPhoto);
    final coverPhoto = await _fileToMultipart(cardCoverPhoto);
    final video = await _fileToMultipart(cardVideo);

    if (photo != null) formMap['cardPhoto'] = photo;
    if (coverPhoto != null) formMap['cardCoverPhoto'] = coverPhoto;
    if (video != null) formMap['cardVideo'] = video;

    return FormData.fromMap(formMap);
  }
}
