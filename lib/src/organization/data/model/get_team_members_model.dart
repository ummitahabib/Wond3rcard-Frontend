class GetTeamMembers {
  final String id;
  final String name;
  final String description;
  final String organizationId;
  final List<Member> members;
  final DateTime createdAt;

  GetTeamMembers({
    required this.id,
    required this.name,
    required this.description,
    required this.organizationId,
    required this.members,
    required this.createdAt,
  });

  factory GetTeamMembers.fromJson(Map<String, dynamic> json) {
    return GetTeamMembers(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      organizationId: json['organizationId'],
      members: (json['members'] as List<dynamic>)
          .map((m) => Member.fromJson(m))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
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
