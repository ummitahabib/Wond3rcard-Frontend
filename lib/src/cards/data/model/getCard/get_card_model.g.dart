// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetCardModelImpl _$$GetCardModelImplFromJson(Map<String, dynamic> json) =>
    _$GetCardModelImpl(
      id: json['_id'] as String,
      cardType: json['cardType'] as String,
      ownerId: json['ownerId'] as String,
      cardName: json['cardName'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      otherName: json['otherName'] as String?,
      active: json['active'] as bool,
      videoUrl: json['videoUrl'] as String?,
      cardPictureUrl: json['cardPictureUrl'] as String?,
      cardCoverUrl: json['cardCoverUrl'] as String?,
      contactInfo:
          ContactInfo.fromJson(json['contactInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GetCardModelImplToJson(_$GetCardModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'cardType': instance.cardType,
      'ownerId': instance.ownerId,
      'cardName': instance.cardName,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'otherName': instance.otherName,
      'active': instance.active,
      'videoUrl': instance.videoUrl,
      'cardPictureUrl': instance.cardPictureUrl,
      'cardCoverUrl': instance.cardCoverUrl,
      'contactInfo': instance.contactInfo,
    };

_$ContactInfoImpl _$$ContactInfoImplFromJson(Map<String, dynamic> json) =>
    _$ContactInfoImpl(
      email: json['email'] as String,
      phone: json['phone'] as String,
      website: json['website'] as String,
    );

Map<String, dynamic> _$$ContactInfoImplToJson(_$ContactInfoImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'phone': instance.phone,
      'website': instance.website,
    };
