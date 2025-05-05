class AddTeamMemberRequest {
  final String memberId;
  final String role;

  AddTeamMemberRequest({
    required this.memberId,
    required this.role,
  });

  Map<String, dynamic> toJson() => {
        'memberId': memberId,
        'role': role,
      };
}

class Team {
  final String id;
  final String name;
  final String description;
  final String organizationId;
  final List<Member> members;
  final DateTime createdAt;

  Team({
    required this.id,
    required this.name,
    required this.description,
    required this.organizationId,
    required this.members,
    required this.createdAt,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      organizationId: json['organizationId'],
      createdAt: DateTime.parse(json['createdAt']),
      members: (json['members'] as List<dynamic>)
          .map((m) => Member.fromJson(m))
          .toList(),
    );
  }
}

class Member {
  final String memberId;
  final String role;

  Member({required this.memberId, required this.role});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      memberId: json['memberId'],
      role: json['role'],
    );
  }
}

enum MemberRole { admin, lead, moderator, member }

extension MemberRoleExtension on MemberRole {
  String get value => toString().split('.').last;
}
