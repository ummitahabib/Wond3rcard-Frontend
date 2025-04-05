class CreateTeamRequest {
  final String name;
  final String description;
  final String leadId;

  CreateTeamRequest({
    required this.name,
    required this.description,
    required this.leadId,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'leadId': leadId,
      };
}

class TeamModel {
  final String id;
  final String name;
  final String description;
  final String organizationId;
  final List<TeamMember> members;
  final DateTime createdAt;

  TeamModel({
    required this.id,
    required this.name,
    required this.description,
    required this.organizationId,
    required this.members,
    required this.createdAt,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      organizationId: json['organizationId'],
      createdAt: DateTime.parse(json['createdAt']),
      members: (json['members'] as List<dynamic>)
          .map((m) => TeamMember.fromJson(m))
          .toList(),
    );
  }
}

class TeamMember {
  final String memberId;
  final String role;

  TeamMember({required this.memberId, required this.role});

  factory TeamMember.fromJson(Map<String, dynamic> json) {
    return TeamMember(
      memberId: json['memberId'],
      role: json['role'],
    );
  }
}
