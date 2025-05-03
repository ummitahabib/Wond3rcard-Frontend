class CreateOrganizationRequest {
  final String name;
  final String businessType;
  final String industry;
  final String companyWebsite;
  final String memberId;

  CreateOrganizationRequest({
    required this.name,
    required this.businessType,
    required this.industry,
    required this.companyWebsite,
    required this.memberId,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "businessType": businessType,
      "industry": industry,
      "companyWebsite": companyWebsite,
      "memberId": memberId,
    };
  }
}
