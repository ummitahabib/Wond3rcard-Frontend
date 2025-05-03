class UpdateOrganizationRequest {
  final String name;
  final String businessType;
  final String industry;
  final String companyWebsite;
  final String creatorId;

  UpdateOrganizationRequest({
    required this.name,
    required this.businessType,
    required this.industry,
    required this.companyWebsite,
    required this.creatorId,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "businessType": businessType,
      "industry": industry,
      "companyWebsite": companyWebsite,
      "creatorId": creatorId,
    };
  }
}

class UpdateOrganizationResponse {
  final String id;
  final String name;
  final String businessType;
  final String industry;
  final String companyWebsite;

  UpdateOrganizationResponse({
    required this.id,
    required this.name,
    required this.businessType,
    required this.industry,
    required this.companyWebsite,
  });

  factory UpdateOrganizationResponse.fromJson(Map<String, dynamic> json) {
    return UpdateOrganizationResponse(
      id: json['_id'],
      name: json['name'],
      businessType: json['businessType'],
      industry: json['industry'],
      companyWebsite: json['companyWebsite'],
    );
  }
}
