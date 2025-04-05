// Request Model: AddMemberRequest
import 'package:wond3rcard/src/organization/data/model/member_model.dart';

class AddMemberRequest {
  final String memberId;
  final String role;

  AddMemberRequest({required this.memberId, required this.role});

  Map<String, dynamic> toJson() => {
        "memberId": memberId,
        "role": role,
      };
}

// Response Model: Organization (Reusing existing fields)
class Organization {
  final String id;
  final String creatorId;
  final String name;
  final String businessType;
  final String industry;
  final String companyWebsite;
  final List<Member> members;
  final DateTime createdAt;
  final DateTime updatedAt;

  Organization({
    required this.id,
    required this.creatorId,
    required this.name,
    required this.businessType,
    required this.industry,
    required this.companyWebsite,
    required this.members,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['_id'],
      creatorId: json['creatorId'],
      name: json['name'],
      businessType: json['businessType'],
      industry: json['industry'],
      companyWebsite: json['companyWebsite'],
      members: (json['members'] as List<dynamic>)
          .map((member) => Member.fromJson(member))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}


