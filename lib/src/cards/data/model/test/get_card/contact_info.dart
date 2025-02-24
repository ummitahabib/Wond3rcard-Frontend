import 'dart:convert';

import 'package:collection/collection.dart';

class ContactInfo {
  List<dynamic>? emailType;
  String? email;
  String? phone;
  String? website;
  String? address;
  List<dynamic>? addresses;

  ContactInfo({
    this.emailType,
    this.email,
    this.phone,
    this.website,
    this.address,
    this.addresses,
  });

  @override
  String toString() {
    return 'ContactInfo(emailType: $emailType, email: $email, phone: $phone, website: $website, address: $address, addresses: $addresses)';
  }

  factory ContactInfo.fromMap(Map<String, dynamic> data) => ContactInfo(
        emailType: data['emailType'] as List<dynamic>?,
        email: data['email'] as String?,
        phone: data['phone'] as String?,
        website: data['website'] as String?,
        address: data['address'] as String?,
        addresses: data['addresses'] as List<dynamic>?,
      );

  Map<String, dynamic> toMap() => {
        'emailType': emailType,
        'email': email,
        'phone': phone,
        'website': website,
        'address': address,
        'addresses': addresses,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ContactInfo].
  factory ContactInfo.fromJson(String data) {
    return ContactInfo.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ContactInfo] to a JSON string.
  String toJson() => json.encode(toMap());

  ContactInfo copyWith({
    List<dynamic>? emailType,
    String? email,
    String? phone,
    String? website,
    String? address,
    List<dynamic>? addresses,
  }) {
    return ContactInfo(
      emailType: emailType ?? this.emailType,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      address: address ?? this.address,
      addresses: addresses ?? this.addresses,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ContactInfo) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      emailType.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      website.hashCode ^
      address.hashCode ^
      addresses.hashCode;
}
