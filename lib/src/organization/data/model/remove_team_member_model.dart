class RemoveTeamMemberResponse {
  final String id;
  final String name;
  final String description;
  final String organizationId;
  final List<TeamMember> members;
  final DateTime createdAt;
  final DateTime updatedAt;

  RemoveTeamMemberResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.organizationId,
    required this.members,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RemoveTeamMemberResponse.fromJson(Map<String, dynamic> json) {
    return RemoveTeamMemberResponse(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      organizationId: json['organizationId'],
      members: (json['members'] as List)
          .map((member) => TeamMember.fromJson(member))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class TeamMember {
  final String memberId;
  final String role;
  final String id;

  TeamMember({
    required this.memberId,
    required this.role,
    required this.id,
  });

  factory TeamMember.fromJson(Map<String, dynamic> json) {
    return TeamMember(
      memberId: json['memberId'],
      role: json['role'],
      id: json['_id'],
    );
  }
}
