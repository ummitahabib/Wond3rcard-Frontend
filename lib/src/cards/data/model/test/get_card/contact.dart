import 'dart:convert';

class ContactInfo {
  final List<String>? emailType;
  final String? email;
  final String? phone;
  final String? website;
  final String? address;
  final List<String>? addresses;

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
        emailType: _toStringList(data['emailType']),
        email: _extractString(data['email']),
        phone: _extractString(data['phone']),
        website: _extractString(data['website']),
        address: _extractString(data['address']),
        addresses: _toStringList(data['addresses']),
      );

  Map<String, dynamic> toMap() => {
        'emailType': emailType,
        'email': email,
        'phone': phone,
        'website': website,
        'address': address,
        'addresses': addresses,
      };

  factory ContactInfo.fromJson(String data) {
    return ContactInfo.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  ContactInfo copyWith({
    List<String>? emailType,
    String? email,
    String? phone,
    String? website,
    String? address,
    List<String>? addresses,
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
    return other.emailType == emailType &&
        other.email == email &&
        other.phone == phone &&
        other.website == website &&
        other.address == address &&
        other.addresses == addresses;
  }

  @override
  int get hashCode =>
      emailType.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      website.hashCode ^
      address.hashCode ^
      addresses.hashCode;

  // Utility to ensure a field is converted to a List<String> safely
  static List<String>? _toStringList(dynamic value) {
    if (value == null) return null;
    if (value is String) return [value];
    if (value is List) return value.map((e) => e.toString()).toList();
    return null;
  }

  // Utility to ensure a field is converted to a single String
  static String? _extractString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    if (value is List && value.isNotEmpty) return value.first.toString();
    return value.toString();
  }
}