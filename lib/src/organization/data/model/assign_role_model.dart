class AssignRoleResponse {
  final String id;
  final String name;
  final String description;
  final String organizationId;
  final List<Member> members;
  final DateTime createdAt;
  final DateTime updatedAt;

  AssignRoleResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.organizationId,
    required this.members,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AssignRoleResponse.fromJson(Map<String, dynamic> json) {
    return AssignRoleResponse(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      organizationId: json['organizationId'],
      members:
          (json['members'] as List).map((m) => Member.fromJson(m)).toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Member {
  final String memberId;
  final String role;
  final String id;

  Member({
    required this.memberId,
    required this.role,
    required this.id,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      memberId: json['memberId'],
      role: json['role'],
      id: json['_id'],
    );
  }
}

enum TeamRole { admin, lead, moderator, member }

extension TeamRoleExtension on TeamRole {
  String get name {
    switch (this) {
      case TeamRole.admin:
        return "admin";
      case TeamRole.lead:
        return "lead";
      case TeamRole.moderator:
        return "moderator";
      case TeamRole.member:
        return "member";
    }
  }
}
