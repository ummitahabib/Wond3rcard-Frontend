class CreateOrganizationResponse {
  final int statusCode;
  final String status;
  final String message;
  final OrganizationPayload payload;

  CreateOrganizationResponse({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.payload,
  });

  factory CreateOrganizationResponse.fromJson(Map<String, dynamic> json) {
    return CreateOrganizationResponse(
      statusCode: json['statusCode'],
      status: json['status'],
      message: json['message'],
      payload: OrganizationPayload.fromJson(json['payload']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'status': status,
      'message': message,
      'payload': payload.toJson(),
    };
  }
}

class OrganizationPayload {
  final String creatorId;
  final String name;
  final List<Member> members;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  OrganizationPayload({
    required this.creatorId,
    required this.name,
    required this.members,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory OrganizationPayload.fromJson(Map<String, dynamic> json) {
    return OrganizationPayload(
      creatorId: json['creatorId'],
      name: json['name'],
      members:
          (json['members'] as List).map((e) => Member.fromJson(e)).toList(),
      id: json['_id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'creatorId': creatorId,
      'name': name,
      'members': members.map((e) => e.toJson()).toList(),
      '_id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }
}

class Member {
  final String memberId;
  final String organizationId;
  final String role;

  Member({
    required this.memberId,
    required this.organizationId,
    required this.role,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      memberId: json['memberId'],
      organizationId: json['organizationId'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'memberId': memberId,
      'organizationId': organizationId,
      'role': role,
    };
  }
}
