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

  factory ContactInfo.fromJson(Map<String, dynamic> json) => ContactInfo(
        emailType: json['emailType'] as List<dynamic>?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        website: json['website'] as String?,
        address: json['address'] as String?,
        addresses: json['addresses'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'emailType': emailType,
        'email': email,
        'phone': phone,
        'website': website,
        'address': address,
        'addresses': addresses,
      };
}
