class CreateOrganizationRequest {
  final String name;

  CreateOrganizationRequest({required this.name});

  factory CreateOrganizationRequest.fromJson(Map<String, dynamic> json) {
    return CreateOrganizationRequest(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
