// Request model for updating an organization
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

  // Convert to JSON for the request payload
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

// Response model for updated organization
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

  // Factory constructor to parse JSON response
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
