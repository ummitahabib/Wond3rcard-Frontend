import 'package:wond3rcard/src/organization/data/model/member_model.dart';

class GetUserOrganization {
  final String id;
  final String creatorId;
  final String name;
  final String businessType;
  final String industry;
  final String companyWebsite;
  final List<Member> members;
  final List<String> teams;
  final DateTime createdAt;
  final DateTime updatedAt;

  GetUserOrganization({
    required this.id,
    required this.creatorId,
    required this.name,
    required this.businessType,
    required this.industry,
    required this.companyWebsite,
    required this.members,
    required this.teams,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to parse from JSON
  factory GetUserOrganization.fromJson(Map<String, dynamic> json) {
    return GetUserOrganization(
      id: json['_id'],
      creatorId: json['creatorId'],
      name: json['name'],
      businessType: json['businessType'],
      industry: json['industry'],
      companyWebsite: json['companyWebsite'],
      members: (json['members'] as List<dynamic>)
          .map((member) => Member.fromJson(member))
          .toList(),
      teams: List<String>.from(json['teams']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

