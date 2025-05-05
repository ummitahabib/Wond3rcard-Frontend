import 'package:wond3rcard/src/organization/data/model/member_model.dart';

class CreateOrganizationResponse {
  final String creatorId;
  final String name;
  final String businessType;
  final String industry;
  final String companyWebsite;
  final List<Member> members;
  final List<dynamic> teams;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  CreateOrganizationResponse({
    required this.creatorId,
    required this.name,
    required this.businessType,
    required this.industry,
    required this.companyWebsite,
    required this.members,
    required this.teams,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CreateOrganizationResponse.fromJson(Map<String, dynamic> json) {
    return CreateOrganizationResponse(
      creatorId: json['creatorId'],
      name: json['name'],
      businessType: json['businessType'],
      industry: json['industry'],
      companyWebsite: json['companyWebsite'],
      members: (json['members'] as List<dynamic>)
          .map((member) => Member.fromJson(member))
          .toList(),
      teams: json['teams'] ?? [],
      id: json['_id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

