class OrganizationInfo {
  String? organizationName;

  OrganizationInfo({this.organizationName});

  factory OrganizationInfo.fromJson(Map<String, dynamic> json) {
    return OrganizationInfo(
      organizationName: json['organizationName'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'organizationName': organizationName,
      };
}
