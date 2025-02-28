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
