// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateCardModelImpl _$$CreateCardModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateCardModelImpl(
      cardType: json['cardType'] as String,
      ownerId: json['ownerId'] as String,
      cardName: json['cardName'] as String,
      suffix: json['suffix'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      middleName: json['middleName'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      designation: json['designation'] as String?,
      notes: json['notes'] as String?,
      primaryColor: json['primaryColor'] as String?,
      secondaryColor: json['secondaryColor'] as String?,
      fontSize: json['fontSize'] as String?,
      fontWeight: json['fontWeight'] as String?,
      fontStyle: json['fontStyle'] as String?,
      fontFamilyName: json['fontFamilyName'] as String?,
      organizationId: json['organizationId'] as String?,
      email: json['email'] as String,
      phone: json['phone'] as String,
      website: json['website'] as String,
      address: json['address'] as String,
      socialMediaLinks: (json['socialMediaLinks'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      textColor: json['textColor'] as String?,
      cardPhoto: const FileConverter().fromJson(json['cardPhoto'] as String?),
      cardCoverPhoto:
          const FileConverter().fromJson(json['cardCoverPhoto'] as String?),
      cardVideo: const FileConverter().fromJson(json['cardVideo'] as String?),
      webCardPhoto: const Uint8ListConverter()
          .fromJson(json['webCardPhoto'] as List<int>?),
      webCardCoverPhoto: const Uint8ListConverter()
          .fromJson(json['webCardCoverPhoto'] as List<int>?),
    );

Map<String, dynamic> _$$CreateCardModelImplToJson(
        _$CreateCardModelImpl instance) =>
    <String, dynamic>{
      'cardType': instance.cardType,
      'ownerId': instance.ownerId,
      'cardName': instance.cardName,
      'suffix': instance.suffix,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'middleName': instance.middleName,
      'dateOfBirth': instance.dateOfBirth,
      'designation': instance.designation,
      'notes': instance.notes,
      'primaryColor': instance.primaryColor,
      'secondaryColor': instance.secondaryColor,
      'fontSize': instance.fontSize,
      'fontWeight': instance.fontWeight,
      'fontStyle': instance.fontStyle,
      'fontFamilyName': instance.fontFamilyName,
      'organizationId': instance.organizationId,
      'email': instance.email,
      'phone': instance.phone,
      'website': instance.website,
      'address': instance.address,
      'socialMediaLinks': instance.socialMediaLinks,
      'textColor': instance.textColor,
      'cardPhoto': const FileConverter().toJson(instance.cardPhoto),
      'cardCoverPhoto': const FileConverter().toJson(instance.cardCoverPhoto),
      'cardVideo': const FileConverter().toJson(instance.cardVideo),
      'webCardPhoto': const Uint8ListConverter().toJson(instance.webCardPhoto),
      'webCardCoverPhoto':
          const Uint8ListConverter().toJson(instance.webCardCoverPhoto),
    };
