
enum MemberRoleEnum { admin, lead, moderator, member }

class ChangeRoleRequest {
  final String memberId;
  final MemberRoleEnum newRole;

  ChangeRoleRequest({required this.memberId, required this.newRole});

  Map<String, dynamic> toJson() => {
        'memberId': memberId,
        'newRole': newRole.name,
      };
}

class OrganizationModel {
  final String id;
  final String name;
  final String businessType;
  final String industry;
  final String companyWebsite;
  final List<MemberModel> members;

  OrganizationModel({
    required this.id,
    required this.name,
    required this.businessType,
    required this.industry,
    required this.companyWebsite,
    required this.members,
  });

  factory OrganizationModel.fromJson(Map<String, dynamic> json) {
    return OrganizationModel(
      id: json['_id'],
      name: json['name'],
      businessType: json['businessType'],
      industry: json['industry'],
      companyWebsite: json['companyWebsite'],
      members: (json['members'] as List<dynamic>)
          .map((m) => MemberModel.fromJson(m))
          .toList(),
    );
  }
}

class MemberModel {
  final String memberId;
  final MemberRoleEnum role;

  MemberModel({required this.memberId, required this.role});

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      memberId: json['memberId'],
      role: MemberRoleEnum.values
          .firstWhere((e) => e.name == json['role'], orElse: () => MemberRoleEnum.member),
    );
  }
}
